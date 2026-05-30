using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;

namespace Web_Development_Assignment
{
    public class ProgressHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private string ConnStr => ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        private readonly JavaScriptSerializer Json = new JavaScriptSerializer();
        public bool IsReusable => false;

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            ctx.Response.Cache.SetNoStore();

            string username = ctx.Session?["Username"]?.ToString();
            if (string.IsNullOrEmpty(username))
            {
                Respond(ctx, new { error = "not_logged_in" });
                return;
            }

            try
            {
                EnsureTables();
                string action = ctx.Request.QueryString["action"];
                switch (action)
                {
                    case "load":            HandleLoad(ctx, username);            break;
                    case "saveLesson":      HandleSaveLesson(ctx, username);      break;
                    case "saveQuiz":        HandleSaveQuiz(ctx, username);        break;
                    case "resetProgress":   HandleResetProgress(ctx, username);   break;
                    case "saveDiscussion":  HandleSaveDiscussion(ctx, username);  break;
                    default:                Respond(ctx, new { error = "unknown_action" }); break;
                }
            }
            catch (Exception ex)
            {
                Respond(ctx, new { error = ex.Message });
            }
        }

        private void Respond(HttpContext ctx, object obj) =>
            ctx.Response.Write(Json.Serialize(obj));

        /* ── Create tables on first run ── */
        private void EnsureTables()
        {
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                const string sql = @"
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='UserCourseProgress' AND xtype='U')
                    CREATE TABLE UserCourseProgress (
                        ProgressID  INT IDENTITY(1,1) PRIMARY KEY,
                        Username    NVARCHAR(100) NOT NULL,
                        CourseID    NVARCHAR(20)  NOT NULL,
                        LessonKey   NVARCHAR(50)  NOT NULL,
                        Status      NVARCHAR(20)  NOT NULL,
                        UpdatedDate DATETIME NOT NULL DEFAULT GETDATE(),
                        CONSTRAINT UQ_UserCourseProgress UNIQUE (Username, CourseID, LessonKey)
                    );
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='QuizAttempts' AND xtype='U')
                    CREATE TABLE QuizAttempts (
                        AttemptID     INT IDENTITY(1,1) PRIMARY KEY,
                        Username      NVARCHAR(100) NOT NULL,
                        CourseID      NVARCHAR(20)  NOT NULL,
                        AttemptNumber INT NOT NULL,
                        Score         INT NOT NULL,
                        Passed        BIT NOT NULL DEFAULT 0,
                        AttemptDate   DATETIME NOT NULL DEFAULT GETDATE()
                    );
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='QuizAnswers' AND xtype='U')
                    CREATE TABLE QuizAnswers (
                        AnswerID       INT IDENTITY(1,1) PRIMARY KEY,
                        AttemptID      INT  NOT NULL,
                        QuestionIndex  INT  NOT NULL,
                        SelectedOption INT  NOT NULL,
                        IsCorrect      BIT  NOT NULL DEFAULT 0,
                        IsSkipped      BIT  NOT NULL DEFAULT 0,
                        CONSTRAINT FK_QuizAnswers_AttemptID FOREIGN KEY (AttemptID)
                            REFERENCES QuizAttempts(AttemptID)
                    );
                    
                    -- Seed discussions for Course 1 (Cybersecurity)
                    IF NOT EXISTS (SELECT 1 FROM Discussions WHERE CourseID = 1 AND Username = 'alex')
                    BEGIN
                        INSERT INTO Discussions (CourseID, Username, Message, DatePosted)
                        VALUES (1, 'alex', 'Welcome to the Cybersecurity Basics discussion forum! Let''s use this space to ask questions about threats and defense strategies.', DATEADD(hour, -10, GETDATE()));
                    END

                    IF NOT EXISTS (SELECT 1 FROM Discussions WHERE CourseID = 1 AND Username = 'lina' AND Message LIKE '%symmetric%')
                    BEGIN
                        INSERT INTO Discussions (CourseID, Username, Message, DatePosted)
                        VALUES (1, 'lina', 'Does anyone have a good explanation of the difference between symmetric and asymmetric encryption?', DATEADD(hour, -9, GETDATE()));
                    END

                    IF NOT EXISTS (SELECT 1 FROM Discussions WHERE CourseID = 1 AND Username = 'admin' AND Message LIKE '%Symmetric encryption%')
                    BEGIN
                        INSERT INTO Discussions (CourseID, Username, Message, DatePosted)
                        VALUES (1, 'admin', 'Sure Lina! Symmetric encryption uses the same key for both encryption and decryption, whereas asymmetric encryption uses a public-private key pair.', DATEADD(hour, -8, GETDATE()));
                    END

                    IF NOT EXISTS (SELECT 1 FROM Discussions WHERE CourseID = 1 AND Username = 'sam p.' AND Message LIKE '%Multi-Factor%')
                    BEGIN
                        INSERT INTO Discussions (CourseID, Username, Message, DatePosted)
                        VALUES (1, 'sam p.', 'Remember: Multi-Factor Authentication (MFA) adds an extra verification layer. Even if someone steals your password, they can''t access your account without your secondary device or biometrics!', DATEADD(day, -1, GETDATE()));
                    END

                    IF NOT EXISTS (SELECT 1 FROM Discussions WHERE CourseID = 1 AND Username = 'daniel' AND Message LIKE '%MD5%')
                    BEGIN
                        INSERT INTO Discussions (CourseID, Username, Message, DatePosted) VALUES
                        (1, 'daniel', 'Is it secure to store user passwords in a database using MD5 hashing?', DATEADD(minute, -30, GETDATE())),
                        (1, 'admin', 'No, MD5 is cryptographically broken and highly vulnerable to collision attacks and brute-forcing. Always use secure, modern salted algorithms like bcrypt or PBKDF2.', DATEADD(minute, -15, GETDATE()));
                    END

                    -- Seed discussions for Course 5 (Python)
                    IF NOT EXISTS (SELECT 1 FROM Discussions WHERE CourseID = 5 AND Username = 'jamie r.')
                    BEGIN
                        INSERT INTO Discussions (CourseID, Username, Message, DatePosted) VALUES
                        (5, 'jamie r.', 'Hey! I''m struggling to understand the difference between a list and a tuple. Can anyone help?', DATEADD(hour, -5, GETDATE())),
                        (5, 'sam p.', 'A list is mutable (changeable after creation), a tuple is immutable (fixed). Use list for changing data: colors = [""red"",""blue""]. Use tuple for fixed data: coords = (10, 20).', DATEADD(hour, -4, GETDATE())),
                        (5, 'maya k.', 'Pro tip: use the Python REPL (type python in terminal) to test snippets instantly without creating a file. It''s like a calculator for Python!', DATEADD(hour, -2, GETDATE())),
                        (5, 'chris l.', 'F-strings are incredibly powerful. You can put expressions inside: print(f""2+2={2+2}"") outputs 2+2=4. Much cleaner than old string formatting!', DATEADD(day, -1, GETDATE()));
                    END

                    IF NOT EXISTS (SELECT 1 FROM Discussions WHERE CourseID = 5 AND Username = 'lina' AND Message LIKE '%IndentationError%')
                    BEGIN
                        INSERT INTO Discussions (CourseID, Username, Message, DatePosted) VALUES
                        (5, 'lina', 'Why do I get an IndentationError in Python? The lines look completely aligned in my editor.', DATEADD(minute, -25, GETDATE())),
                        (5, 'admin', 'IndentationErrors are usually caused by mixing tabs and spaces in your code. Python treats tabs and spaces differently. Configure your code editor to insert spaces when you press Tab!', DATEADD(minute, -10, GETDATE()));
                    END";
                using (var cmd = new SqlCommand(sql, conn))
                    cmd.ExecuteNonQuery();
            }
        }

        /* ── Load all progress for a user + course ── */
        private void HandleLoad(HttpContext ctx, string username)
        {
            string courseId = ctx.Request.QueryString["courseID"] ?? "0";
            var lessons  = new Dictionary<string, string>();
            int?   bestScore   = null;
            int    lastScore   = -1;
            bool   quizPassed  = false;
            int    attempts    = 0;
            var    lastAnswers = new List<Dictionary<string, object>>();

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                // Lesson statuses
                using (var cmd = new SqlCommand(
                    "SELECT LessonKey, Status FROM UserCourseProgress WHERE Username=@u AND CourseID=@c", conn))
                {
                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@c", courseId);
                    using (var r = cmd.ExecuteReader())
                        while (r.Read())
                            lessons[r["LessonKey"].ToString()] = r["Status"].ToString();
                }

                // Quiz summary: count, best score, passed flag
                using (var cmd = new SqlCommand(@"
                    SELECT COUNT(*),
                           MAX(Score),
                           MAX(CAST(Passed AS INT)),
                           (SELECT TOP 1 Score FROM QuizAttempts
                            WHERE Username=@u AND CourseID=@c
                            ORDER BY AttemptDate DESC)
                    FROM QuizAttempts WHERE Username=@u AND CourseID=@c", conn))
                {
                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@c", courseId);
                    using (var r = cmd.ExecuteReader())
                    {
                        if (r.Read() && !r.IsDBNull(0))
                        {
                            attempts   = Convert.ToInt32(r[0]);
                            if (!r.IsDBNull(1)) bestScore = Convert.ToInt32(r[1]);
                            if (!r.IsDBNull(2)) quizPassed = Convert.ToInt32(r[2]) == 1;
                            if (!r.IsDBNull(3)) lastScore  = Convert.ToInt32(r[3]);
                        }
                    }
                }

                // Last attempt's answers (so UI can show previous results on reload)
                if (attempts > 0)
                {
                    using (var cmd = new SqlCommand(@"
                        SELECT qa.QuestionIndex, qa.SelectedOption, qa.IsCorrect, qa.IsSkipped
                        FROM QuizAnswers qa
                        INNER JOIN QuizAttempts att ON qa.AttemptID = att.AttemptID
                        WHERE att.Username=@u AND att.CourseID=@c
                          AND att.AttemptID = (
                              SELECT TOP 1 AttemptID FROM QuizAttempts
                              WHERE Username=@u AND CourseID=@c
                              ORDER BY AttemptDate DESC)
                        ORDER BY qa.QuestionIndex", conn))
                    {
                        cmd.Parameters.AddWithValue("@u", username);
                        cmd.Parameters.AddWithValue("@c", courseId);
                        using (var r = cmd.ExecuteReader())
                        {
                            while (r.Read())
                            {
                                lastAnswers.Add(new Dictionary<string, object>
                                {
                                    ["qIdx"]    = Convert.ToInt32(r["QuestionIndex"]),
                                    ["sel"]     = Convert.ToInt32(r["SelectedOption"]),
                                    ["correct"] = Convert.ToBoolean(r["IsCorrect"]),
                                    ["skipped"] = Convert.ToBoolean(r["IsSkipped"])
                                });
                            }
                        }
                    }
                }
            }

            // Load discussions from DB for this course
            var discussions = new List<Dictionary<string, object>>();
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (var cmd = new SqlCommand(@"
                    SELECT d.Username, d.Message, d.DatePosted, ISNULL(u.UserType, 'Member') AS UserType
                    FROM Discussions d
                    LEFT JOIN Users u ON d.Username = u.Username
                    WHERE d.CourseID = @c
                    ORDER BY d.DatePosted ASC", conn))
                {
                    cmd.Parameters.AddWithValue("@c", courseId);
                    using (var r = cmd.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            discussions.Add(new Dictionary<string, object>
                            {
                                ["username"] = r["Username"].ToString(),
                                ["msg"]      = r["Message"].ToString(),
                                ["date"]     = Convert.ToDateTime(r["DatePosted"]).ToString("yyyy-MM-dd HH:mm:ss"),
                                ["userType"] = r["UserType"].ToString()
                            });
                        }
                    }
                }
            }

            Respond(ctx, new
            {
                lessons      = lessons,
                quizPassed   = quizPassed,
                quizAttempts = attempts,
                bestScore    = (object)bestScore ?? false,
                lastScore    = lastScore >= 0 ? (object)lastScore : false,
                lastAnswers  = lastAnswers,
                discussions  = discussions
            });
        }

        /* ── Upsert a single lesson status ── */
        private void HandleSaveLesson(HttpContext ctx, string username)
        {
            string body;
            using (var r = new StreamReader(ctx.Request.InputStream))
                body = r.ReadToEnd();

            var data     = Json.Deserialize<Dictionary<string, object>>(body);
            string cId   = data.ContainsKey("courseID")  ? data["courseID"].ToString()  : "0";
            string lKey  = data.ContainsKey("lessonKey") ? data["lessonKey"].ToString() : "";
            string status= data.ContainsKey("status")    ? data["status"].ToString()    : "";

            if (string.IsNullOrEmpty(lKey) || string.IsNullOrEmpty(status))
            { Respond(ctx, new { error = "missing_params" }); return; }

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                // Don't downgrade complete → visited
                const string sql = @"
                    IF EXISTS (SELECT 1 FROM UserCourseProgress WHERE Username=@u AND CourseID=@c AND LessonKey=@l)
                        UPDATE UserCourseProgress
                           SET Status = CASE WHEN Status='complete' AND @s='visited' THEN 'complete' ELSE @s END,
                               UpdatedDate = GETDATE()
                         WHERE Username=@u AND CourseID=@c AND LessonKey=@l
                    ELSE
                        INSERT INTO UserCourseProgress (Username,CourseID,LessonKey,Status)
                        VALUES (@u,@c,@l,@s)";
                using (var cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@c", cId);
                    cmd.Parameters.AddWithValue("@l", lKey);
                    cmd.Parameters.AddWithValue("@s", status);
                    cmd.ExecuteNonQuery();
                }
            }
            Respond(ctx, new { ok = true });
        }

        /* ── Save a full quiz attempt ── */
        private void HandleSaveQuiz(HttpContext ctx, string username)
        {
            string body;
            using (var r = new StreamReader(ctx.Request.InputStream))
                body = r.ReadToEnd();

            var data    = Json.Deserialize<Dictionary<string, object>>(body);
            string cId  = data.ContainsKey("courseID") ? data["courseID"].ToString() : "0";
            int score   = Convert.ToInt32(data["score"]);
            bool passed = Convert.ToBoolean(data["passed"]);
            var rawAnswers = data.ContainsKey("answers")
                ? data["answers"] as System.Collections.ArrayList
                : null;

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                // Count existing attempts
                int prevAttempts;
                using (var cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM QuizAttempts WHERE Username=@u AND CourseID=@c", conn))
                {
                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@c", cId);
                    prevAttempts = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // Check already passed
                bool alreadyPassed;
                using (var cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM QuizAttempts WHERE Username=@u AND CourseID=@c AND Passed=1", conn))
                {
                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@c", cId);
                    alreadyPassed = Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }

                if (alreadyPassed)
                { Respond(ctx, new { error = "already_passed" }); return; }

                if (prevAttempts >= 3)
                { Respond(ctx, new { error = "max_attempts", attempts = prevAttempts }); return; }

                int attemptNum = prevAttempts + 1;

                // Insert attempt
                int attemptId;
                using (var cmd = new SqlCommand(@"
                    INSERT INTO QuizAttempts (Username,CourseID,AttemptNumber,Score,Passed)
                    OUTPUT INSERTED.AttemptID
                    VALUES (@u,@c,@n,@s,@p)", conn))
                {
                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@c", cId);
                    cmd.Parameters.AddWithValue("@n", attemptNum);
                    cmd.Parameters.AddWithValue("@s", score);
                    cmd.Parameters.AddWithValue("@p", passed);
                    attemptId = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // Insert per-question answers
                if (rawAnswers != null)
                {
                    foreach (Dictionary<string, object> ans in rawAnswers)
                    {
                        using (var cmd = new SqlCommand(@"
                            INSERT INTO QuizAnswers
                                (AttemptID,QuestionIndex,SelectedOption,IsCorrect,IsSkipped)
                            VALUES (@a,@qi,@so,@ic,@is)", conn))
                        {
                            cmd.Parameters.AddWithValue("@a",  attemptId);
                            cmd.Parameters.AddWithValue("@qi", Convert.ToInt32(ans["qIdx"]));
                            cmd.Parameters.AddWithValue("@so", Convert.ToInt32(ans["sel"]));
                            cmd.Parameters.AddWithValue("@ic", Convert.ToBoolean(ans["correct"]));
                            cmd.Parameters.AddWithValue("@is", Convert.ToBoolean(ans["skipped"]));
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                // If passed, mark quiz lesson complete in UserCourseProgress
                if (passed)
                {
                    const string upsertSql = @"
                        IF EXISTS (SELECT 1 FROM UserCourseProgress
                                   WHERE Username=@u AND CourseID=@c AND LessonKey='quiz')
                            UPDATE UserCourseProgress SET Status='complete', UpdatedDate=GETDATE()
                             WHERE Username=@u AND CourseID=@c AND LessonKey='quiz'
                        ELSE
                            INSERT INTO UserCourseProgress (Username,CourseID,LessonKey,Status)
                            VALUES (@u,@c,'quiz','complete')";
                    using (var cmd = new SqlCommand(upsertSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@u", username);
                        cmd.Parameters.AddWithValue("@c", cId);
                        cmd.ExecuteNonQuery();
                    }
                }

                Respond(ctx, new { ok = true, attemptNumber = attemptNum, attemptsLeft = 3 - attemptNum });
            }
        }

        /* ── Delete all progress for a user + course ── */
        private void HandleResetProgress(HttpContext ctx, string username)
        {
            string body;
            using (var r = new StreamReader(ctx.Request.InputStream))
                body = r.ReadToEnd();
            var data = Json.Deserialize<Dictionary<string, object>>(body);
            string cId = data.ContainsKey("courseID") ? data["courseID"].ToString() : "0";

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (var cmd = new SqlCommand(
                    "DELETE FROM UserCourseProgress WHERE Username=@u AND CourseID=@c", conn))
                {
                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@c", cId);
                    cmd.ExecuteNonQuery();
                }
                using (var cmd = new SqlCommand(@"
                    DELETE FROM QuizAnswers WHERE AttemptID IN (
                        SELECT AttemptID FROM QuizAttempts WHERE Username=@u AND CourseID=@c
                    )", conn))
                {
                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@c", cId);
                    cmd.ExecuteNonQuery();
                }
                using (var cmd = new SqlCommand(
                    "DELETE FROM QuizAttempts WHERE Username=@u AND CourseID=@c", conn))
                {
                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@c", cId);
                    cmd.ExecuteNonQuery();
                }
            }
            Respond(ctx, new { ok = true });
        }

        /* ── Save a discussion comment ── */
        private void HandleSaveDiscussion(HttpContext ctx, string username)
        {
            string body;
            using (var r = new StreamReader(ctx.Request.InputStream))
                body = r.ReadToEnd();

            var data = Json.Deserialize<Dictionary<string, object>>(body);
            string courseId = data.ContainsKey("courseID") ? data["courseID"].ToString() : "0";
            string msg = data.ContainsKey("message") ? data["message"].ToString() : "";

            if (string.IsNullOrEmpty(msg))
            {
                Respond(ctx, new { error = "empty_message" });
                return;
            }

            using (var conn = new SqlConnection(ConnStr))
            {
                string query = "INSERT INTO Discussions (CourseID, Username, Message, DatePosted) VALUES (@CourseID, @Username, @Message, @DatePosted)";
                using (var cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Message", msg);
                    cmd.Parameters.AddWithValue("@DatePosted", DateTime.Now);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            Respond(ctx, new { ok = true });
        }
    }
}
