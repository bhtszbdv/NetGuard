# Handoff: CyberSecurityPage.aspx Rewrite

## Goal
Completely rewrite `CyberSecurityPage.aspx` to match `CoursePage.aspx` (the Python course page) — same layout, same features — but with cybersecurity content.

---

## What's Done
- Routing bug fixed: `MemberDashboard.aspx.cs` `OpenCourse()` uses `OrdinalIgnoreCase` to route "CyberSecurity Basics" → `CyberSecurityPage.aspx`
- Build fixed: missing files added to `.csproj`, project compiles clean
- `README.md` created at project root
- Site runs on IIS Express (tested HTTP 200 on all pages)

## What's Broken
`CyberSecurityPage.aspx` is a **broken partial file**. Problems:
1. `panel-auth` and `panel-best` are nested **inside** `panel-intro` div (missing closing `</div>`)
2. Sidebar `.li` elements have no `id` attributes (`id="li-intro"` etc. required by JS)
3. `.ls` status dots have no IDs (`id="st-intro"` etc.)
4. No banner divs (`id="bn-intro"`, `id="bn-auth"`, `id="bn-best"`)
5. Missing panels: `panel-labs`, `panel-quiz`, `panel-disc`, `panel-feedback`, `panel-cert-locked`, `panel-cert-unlocked`
6. Missing CSS: quiz, lab, discussion, cert, brand header, user menu styles
7. Missing topbar: no save indicator, no user menu dropdown
8. Missing JS: no progress engine, no quiz engine, no lab engine, no save/load
9. `form` tag missing `style="display:contents;"`
10. No brand header (back-to-dashboard click area) in sidebar

---

## The Task: Full Rewrite of CyberSecurityPage.aspx

Use `CoursePage.aspx` as the **exact template**. Copy its structure and CSS verbatim, then substitute cybersecurity content.

### Critical Constraints
- `CyberSecurityPage.aspx.designer.cs` only declares `form1` (HtmlForm) and `lblCourseTitle` (HtmlGenericControl)
- So `lblCourseTitle` must be a **`<div>`** not `<asp:Label>`:
  ```html
  <div id="lblCourseTitle" runat="server">CyberSecurity Basics</div>
  ```
- No hidden `btnback` button (not in designer). Use JS navigation instead:
  ```html
  <div class="sb-brand" onclick="window.location.href='MemberDashboard.aspx'" title="Back to My Courses">
  ```
- `CodeBehind="CyberSecurityPage.aspx.cs"` `Inherits="Web_Development_Assignment.CyberSecurityPage"`

### CSS Changes from CoursePage
Copy ALL CSS from CoursePage.aspx exactly, then add these extra classes:
```css
/* Cybersecurity lab uses text input, not dark code editor */
.lab-text-area{width:100%;min-height:72px;padding:12px 14px;background:#fff;color:var(--text);border:2px solid #e5e7eb;border-radius:10px;font-family:inherit;font-size:15px;line-height:1.6;resize:vertical;outline:none;transition:border-color .2s;}
.lab-text-area:focus{border-color:var(--primary);box-shadow:0 0 0 3px rgba(0,153,255,.1);}
.lab-text-area::placeholder{color:#9ca3af;}
.lab-ans-text{background:#f0fdf4;padding:14px 18px;font-size:15px;color:#166534;font-weight:600;border-top:1px solid #e5e7eb;line-height:1.5;}
```

---

## Sidebar Structure

```html
<!-- Brand header (replaces hidden btnback from CoursePage) -->
<div class="sb-brand" onclick="window.location.href='MemberDashboard.aspx'" title="Back to My Courses">
    <i class="fa-solid fa-chevron-left sb-back-arrow"></i>
    <img src="images/netguard_logo.png" alt="NetGuard" class="sb-brand-logo" />
    <div>
        <div class="sb-brand-name">NetGuard</div>
        <div class="sb-brand-sub">Learning Platform</div>
    </div>
</div>

<div class="sb-top">
    <div class="sb-title">
        <div id="lblCourseTitle" runat="server">CyberSecurity Basics</div>
    </div>
    <div class="op-row"><span class="op-lbl">Progress</span><span class="op-pct" id="opPct">0%</span></div>
    <div class="op-bar"><div class="op-fill" id="opFill" style="width:0%"></div></div>
</div>

<div class="sb-tabs"><div class="sb-tab active">Course Outline</div></div>

<div class="sb-scroll">
    <!-- Module 1 -->
    <div class="mg" id="mod1">
        <div class="mh" onclick="toggleMod('mod1')">
            <span class="mn">Module 1: Cybersecurity Fundamentals</span>
            <em class="mc" id="m1c">0 / 3</em>
            <i class="fa-solid fa-chevron-down mchev"></i>
        </div>
        <div class="ml">
            <div class="li active" id="li-intro" onclick="go(this,'intro')">
                <div class="ls" id="st-intro"><i class="fa-solid fa-check"></i></div>
                <div class="li-info"><div class="li-name">Foundations &amp; Threats</div></div>
                <span class="li-dur">15 min</span>
            </div>
            <div class="li" id="li-auth" onclick="go(this,'auth')">
                <div class="ls" id="st-auth"><i class="fa-solid fa-check"></i></div>
                <div class="li-info"><div class="li-name">Authentication &amp; Encryption</div></div>
                <span class="li-dur">18 min</span>
            </div>
            <div class="li" id="li-best" onclick="go(this,'best')">
                <div class="ls" id="st-best"><i class="fa-solid fa-check"></i></div>
                <div class="li-info"><div class="li-name">Security Best Practices</div></div>
                <span class="li-dur">20 min</span>
            </div>
        </div>
    </div>
    <!-- Module 2 -->
    <div class="mg" id="mod2">
        <div class="mh" onclick="toggleMod('mod2')">
            <span class="mn">Module 2: Practice &amp; Assessment</span>
            <em class="mc" id="m2c">0 / 3</em>
            <i class="fa-solid fa-chevron-down mchev"></i>
        </div>
        <div class="ml">
            <div class="li" id="li-labs" onclick="go(this,'labs')">
                <div class="ls" id="st-labs"><i class="fa-solid fa-check"></i></div>
                <div class="li-info"><div class="li-name">Security Lab &mdash; Exercises</div></div>
                <span class="li-dur">30 min</span>
            </div>
            <div class="li" id="li-quiz" onclick="go(this,'quiz')">
                <div class="ls" id="st-quiz"><i class="fa-solid fa-check"></i></div>
                <div class="li-info"><div class="li-name">Self-Assessment Quiz</div></div>
                <span class="li-dur">20 min</span>
            </div>
            <div class="li" id="li-disc" onclick="go(this,'disc')">
                <div class="ls" id="st-disc"><i class="fa-solid fa-check"></i></div>
                <div class="li-info"><div class="li-name">Discussion Forum</div></div>
                <span class="li-dur">Open</span>
            </div>
        </div>
    </div>
    <!-- Standalone -->
    <div class="sa" id="li-feedback" onclick="go(this,'feedback')">
        <i class="fa-solid fa-comment-dots" style="color:#6b7280;width:20px;text-align:center;"></i>
        <span>Course Feedback</span>
        <i class="fa-solid fa-chevron-right" style="margin-left:auto;font-size:10px;color:#374151;"></i>
    </div>
    <div class="sa cert-sa cert-locked" id="li-cert" onclick="certClick()">
        <i class="fa-solid fa-lock" id="certSbIco" style="width:20px;text-align:center;"></i>
        <span id="certSbTxt">Course Certificate</span>
        <span id="certSbNew" style="display:none;margin-left:auto;font-size:11px;background:#fef3c7;color:#92400e;padding:2px 8px;border-radius:10px;font-weight:700;">NEW</span>
    </div>
</div>
```

---

## JavaScript Config (replaces Python values)

```javascript
var courseID = '<%= Request.QueryString["CourseID"] ?? "" %>';
var username = '<%= Session["Username"] ?? "guest" %>';

var LESSONS_ORDER = ['intro','auth','best','labs','quiz','disc','feedback','cert'];
var TRACKABLE     = ['intro','auth','best','labs','quiz','disc'];
var PAGES         = { feedback:'Feedback.aspx', cert:'Certificates.aspx' };
var TITLES = {
    intro:    '1.0: Foundations &amp; Threats',
    auth:     '1.1: Authentication &amp; Encryption',
    best:     '1.2: Security Best Practices',
    labs:     '2.0: Security Lab &mdash; Exercises',
    quiz:     '2.1: Self-Assessment Quiz',
    disc:     '2.2: Discussion Forum',
    feedback: 'Course Feedback',
    cert:     'Course Certificate'
};
```

Module completion counters:
```javascript
var m1 = ['intro','auth','best'];
var m2 = ['labs','quiz','disc'];
// nonQuiz for cert req = ['intro','auth','best','labs','disc'] — 5 items
```

`switchLesson` `allP` array:
```javascript
var allP = ['intro','auth','best','labs','quiz','disc','feedback','cert-locked','cert-unlocked'];
```

Default/reset start lesson: `'intro'` (not `'notes'`)

`doReset()` redirect:
```javascript
switchLesson(document.getElementById('li-intro'), 'intro');
```

Quiz locked "Review Course Notes" button:
```javascript
onclick="switchLesson(document.getElementById('li-intro'),'intro')"
```

---

## Lab Engine Changes

In the lab, replace `lab-code-area` textarea with `lab-text-area`, and the answer `<pre>` with a `<div>`:

```html
<div class="lab-code-lbl"><i class="fa-solid fa-pen" style="color:var(--primary);"></i> Your Answer</div>
<textarea class="lab-text-area" id="labCodeArea" spellcheck="false" placeholder="Type your answer here..."></textarea>
```

Answer display:
```html
<div class="lab-answer" id="labAnswer" style="display:none;">
    <div class="lab-ans-hdr"><i class="fa-solid fa-circle-check"></i> Correct Answer</div>
    <div class="lab-ans-text" id="labAnsCode"></div>
    <div class="lab-ans-exp" id="labAnsExp"></div>
</div>
```

`labNorm` — case-insensitive for text answers:
```javascript
function labNorm(text) {
    return text.toLowerCase().trim().replace(/\s*,\s*/g, ', ').replace(/\s+/g, ' ');
}
```

Placeholder on wrong answer:
```javascript
area.placeholder = 'Retype the correct answer here...';
```

`renderLabEx` initial placeholder:
```javascript
area.placeholder = 'Type your answer here...';
```

---

## 6 Lab Exercises

```javascript
var labExercises = [
    {
        q: 'Type the three components of the CIA Triad, separated by commas.',
        hint: 'Hint: These are the three core principles of information security.',
        answer: 'Confidentiality, Integrity, Availability',
        exp: 'The CIA Triad: <strong>Confidentiality</strong> (data only accessible to authorised users), <strong>Integrity</strong> (data is accurate and unaltered), <strong>Availability</strong> (systems accessible when needed).'
    },
    {
        q: 'What is the default port number for HTTPS?',
        hint: 'Hint: HTTP uses port 80 — HTTPS uses a different number.',
        answer: '443',
        exp: 'HTTPS uses port <strong>443</strong>. HTTP uses port 80. When you visit an https:// site, your browser connects on port 443 and all traffic is encrypted via TLS.'
    },
    {
        q: 'Does symmetric or asymmetric encryption use the same key for both encryption and decryption? Type one word.',
        hint: 'Hint: The word "symmetric" means equal/same on both sides.',
        answer: 'symmetric',
        exp: '<strong>Symmetric encryption</strong> uses the same key to both encrypt and decrypt. Asymmetric uses a key pair — public key to encrypt, private key to decrypt.'
    },
    {
        q: 'List the three factor categories of Multi-Factor Authentication, separated by commas.',
        hint: 'Hint: They relate to Knowledge, Possession, and Inherence.',
        answer: 'Something you Know, Something you Have, Something you Are',
        exp: 'MFA combines at least two of: <strong>Something you Know</strong> (password/PIN), <strong>Something you Have</strong> (phone/token), <strong>Something you Are</strong> (fingerprint/face scan).'
    },
    {
        q: 'Complete the security principle: "Principle of Least ___". Type the missing word.',
        hint: 'Hint: This principle restricts users to the minimum access they need.',
        answer: 'Privilege',
        exp: 'The <strong>Principle of Least Privilege (PoLP)</strong> means users are granted only the minimum access needed to do their job — limiting damage if an account is compromised.'
    },
    {
        q: 'Name three types of malware, separated by commas.',
        hint: 'Hint: Think about self-replicating programs, network-spreading threats, and data-encrypting extortion tools.',
        answer: 'Viruses, Worms, Ransomware',
        exp: 'Common malware: <strong>Viruses</strong> (attach to files, spread when run), <strong>Worms</strong> (self-replicate across networks), <strong>Ransomware</strong> (encrypts files and demands payment).'
    }
];
```

---

## 8 Quiz Questions

```javascript
var questions = [
    {
        q: 'What does the "C" in the CIA Triad stand for?',
        opts: ['Cybersecurity','Confidentiality','Control','Configuration'],
        ans: 1,
        exp: 'The CIA Triad stands for <strong>Confidentiality</strong>, Integrity, and Availability. Confidentiality ensures data is only accessible to authorised users, typically through encryption and access controls.'
    },
    {
        q: 'Which type of attack uses deceptive emails to steal user credentials?',
        opts: ['Ransomware','Phishing','SQL Injection','DDoS'],
        ans: 1,
        exp: '<strong>Phishing</strong> uses deceptive emails that appear legitimate to trick users into revealing passwords or clicking malicious links. It is one of the most common social engineering attacks.'
    },
    {
        q: 'Which of the following is an example of Multi-Factor Authentication (MFA)?',
        opts: ['Username and password only','Password and fingerprint scan','Two different passwords','A security question only'],
        ans: 1,
        exp: 'MFA requires two or more verification factors from different categories. A <strong>password + fingerprint</strong> combines "something you know" with "something you are" — two distinct factors.'
    },
    {
        q: 'What does symmetric encryption use to encrypt and decrypt data?',
        opts: ['Two different keys (public and private)','The same key for both','A digital certificate','A one-way hash function'],
        ans: 1,
        exp: '<strong>Symmetric encryption</strong> uses the same key to both encrypt and decrypt. It is fast but requires a secure way to share the key. Examples: AES, DES. Asymmetric uses a public/private key pair.'
    },
    {
        q: 'What is the primary purpose of a firewall?',
        opts: ['Monitor and control incoming/outgoing network traffic','Encrypt data stored on disk','Store user passwords securely','Scan files for viruses'],
        ans: 0,
        exp: 'A <strong>firewall</strong> monitors and controls network traffic based on security rules. It acts as a barrier between trusted internal networks and untrusted external ones, blocking unauthorised access.'
    },
    {
        q: 'What is ransomware?',
        opts: ['A type of phishing email','Malware that encrypts data and demands payment','A network vulnerability scanner','A secure password manager'],
        ans: 1,
        exp: '<strong>Ransomware</strong> is malware that encrypts a victim\'s files and demands a ransom payment for the decryption key. Notable examples include WannaCry and LockBit.'
    },
    {
        q: 'The Principle of Least Privilege (PoLP) means:',
        opts: ['Granting users only the minimum permissions needed for their job','Giving all administrators full system access','Restricting all remote network access','Encrypting all user account data'],
        ans: 0,
        exp: 'The <strong>Principle of Least Privilege</strong> limits user and system access rights to the bare minimum required. This reduces the attack surface — if an account is compromised, damage is contained.'
    },
    {
        q: 'Which port does HTTPS use by default?',
        opts: ['80','443','8080','22'],
        ans: 1,
        exp: 'HTTPS uses port <strong>443</strong>. HTTP uses port 80. Port 8080 is a common alternative HTTP port. Port 22 is used by SSH. Always look for "https://" and port 443 for secure web connections.'
    }
];
```

---

## 3 Discussion Posts (Cybersecurity themed)

```html
<!-- Post 1 -->
<div class="dpost">
    <div class="ph">
        <div class="pav" style="background:linear-gradient(135deg,#6366f1,#4f46e5);">AM</div>
        <div class="pm"><div class="pa">Alex M.</div><div class="pt">2 hours ago</div></div>
    </div>
    <div class="pb"><p>Can someone explain the difference between phishing and spear phishing? Are they basically the same thing?</p></div>
    <div class="pacts"><button type="button" class="pab" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> <span>5</span></button></div>
    <div class="preps">
        <div class="rrow">
            <div class="rav" style="background:linear-gradient(135deg,#0099ff,#007acc);">JL</div>
            <div class="rbub">
                <div class="ra">Jamie L. · 1 hour ago</div>
                <p>Phishing casts a wide net — generic emails sent to thousands of people. Spear phishing targets a specific person or organisation using personalised details (your name, company, role). Spear phishing is far more dangerous because it's harder to spot.</p>
            </div>
        </div>
    </div>
</div>

<!-- Post 2 -->
<div class="dpost">
    <div class="ph">
        <div class="pav" style="background:linear-gradient(135deg,#22c55e,#16a34a);">SK</div>
        <div class="pm"><div class="pa">Sam K.</div><div class="pt">5 hours ago</div></div>
    </div>
    <div class="pb"><p>Pro tip: always enable 2FA on your accounts. Even if your password is stolen, 2FA blocks the attacker. Use an authenticator app (Google Authenticator, Authy) instead of SMS — SIM swapping can intercept text messages.</p></div>
    <div class="pacts"><button type="button" class="pab" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> <span>12</span></button></div>
</div>

<!-- Post 3 -->
<div class="dpost">
    <div class="ph">
        <div class="pav" style="background:linear-gradient(135deg,#f59e0b,#d97706);">RP</div>
        <div class="pm"><div class="pa">Riley P.</div><div class="pt">Yesterday</div></div>
    </div>
    <div class="pb"><p>Learned something useful today — IDS vs IPS: an IDS (Intrusion Detection System) only detects and alerts on suspicious activity, while an IPS (Intrusion Prevention System) actively blocks the threat. Think of IDS as a security camera and IPS as a security guard.</p></div>
    <div class="pacts"><button type="button" class="pab" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> <span>8</span></button></div>
</div>
```

Disc panel header:
```html
<div class="lhdr">
    <h1>Discussion Forum</h1>
    <div class="lmeta"><i class="fa-solid fa-users"></i> <span id="discCnt">3</span> posts &nbsp;&middot;&nbsp; CyberSecurity Basics</div>
</div>
```

Post box placeholder:
```html
<textarea id="newPost" placeholder="Share a question, tip, or insight about cybersecurity..."></textarea>
```

---

## Cert Panel Text Changes

`panel-cert-locked`:
- Title: `"Complete all requirements below to earn your official NetGuard CyberSecurity Basics certificate."`
- lessons req text: `"0 of 5 lessons marked complete"`

`panel-cert-unlocked` header:
```html
<h2>Certificate Earned</h2>
<p>CyberSecurity Basics &mdash; NetGuard</p>
```

`panel-cert-unlocked` body:
```html
<p>You have completed all course lessons and passed the assessment. Your official NetGuard CyberSecurity Basics certificate is ready.</p>
```

`#panel-cert-unlocked .cert-ul-header` override (keep purple from CoursePage, it's in CSS already):
```css
#panel-cert-unlocked .cert-ul-header{background:#4c1d95;}
```

---

## Quiz Result Messages

```javascript
var msgs = {
    pass: 'Excellent! You scored '+pct+'% and passed the CyberSecurity assessment. Your certificate is now unlocked.',
    mid:  'You scored '+pct+'%. You need 80% to pass. Review the lessons and try again.',
    low:  'You scored '+pct+'%. Study the course material carefully — focus on the areas where you made mistakes.'
};
```

---

## Quick Checklist

- [ ] Page directive: `CodeBehind="CyberSecurityPage.aspx.cs"` `Inherits="Web_Development_Assignment.CyberSecurityPage"`
- [ ] `<form id="form1" runat="server" style="display:contents;">`
- [ ] `<div id="lblCourseTitle" runat="server">` (NOT asp:Label)
- [ ] No hidden btnback button anywhere
- [ ] All 9 panels present with correct IDs (intro, auth, best, labs, quiz, disc, feedback, cert-locked, cert-unlocked)
- [ ] All `.li` elements have `id="li-intro"` etc.
- [ ] All `.ls` dots have `id="st-intro"` etc.
- [ ] All banner divs present: `id="bn-intro"`, `id="bn-auth"`, `id="bn-best"`, `id="bn-labs"`
- [ ] Topbar has save indicator `id="tbSaveInd"` and user menu
- [ ] `LESSONS_ORDER` starts with `intro` not `notes`
- [ ] `labNorm` uses `.toLowerCase()` (case-insensitive)
- [ ] `labCodeArea` textarea uses class `lab-text-area` (not `lab-code-area`)
- [ ] `labAnsCode` is a `<div>` (not `<pre>`)
- [ ] `initLab()` called in `DOMContentLoaded`
- [ ] `loadDiscussion()` called in `DOMContentLoaded`
- [ ] `ProgressHandler.ashx` fetch calls present (same URL as CoursePage)

---

## File Locations

| File | Path |
|---|---|
| Template (copy from) | `Web Development Assignment\CoursePage.aspx` |
| Target (rewrite) | `Web Development Assignment\CyberSecurityPage.aspx` |
| Code-behind (do not edit) | `Web Development Assignment\CyberSecurityPage.aspx.cs` |
| Designer (do not edit) | `Web Development Assignment\CyberSecurityPage.aspx.designer.cs` |
| Progress API | `Web Development Assignment\ProgressHandler.ashx` |
