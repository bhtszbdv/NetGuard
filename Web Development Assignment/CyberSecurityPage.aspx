<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CyberSecurityPage.aspx.cs" Inherits="Web_Development_Assignment.CyberSecurityPage" ResponseEncoding="UTF-8" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>CyberSecurity Basics - NetGuard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        :root {
            --primary:#0099ff; --primary-dark:#007acc;
            --sb:#111827; --sb-hover:#1f2937; --sb-active:rgba(0,153,255,.12);
            --sb-border:rgba(255,255,255,.07);
            --text:#1f2937; --muted:#6b7280;
            --green:#22c55e; --green-d:#16a34a;
            --red:#ef4444; --amber:#f59e0b;
        }
        *{box-sizing:border-box;margin:0;padding:0;}
        body{font-family:'Inter','Segoe UI',Tahoma,sans-serif;display:flex;height:100vh;overflow:hidden;background:#f3f4f6;}

        /* ══ SIDEBAR ══ */
        .sb{width:300px;min-width:300px;background:var(--sb);display:flex;flex-direction:column;height:100vh;overflow:hidden;}
        .sb-top{padding:16px 20px 14px;border-bottom:1px solid var(--sb-border);}
        .back-btn{background:none;border:none;color:#9ca3af;font-size:13px;cursor:pointer;display:flex;align-items:center;gap:6px;margin-bottom:12px;font-family:inherit;transition:color .2s;}
        .back-btn:hover{color:#fff;}
        .sb-title{font-size:13px;font-weight:700;color:#f3f4f6;line-height:1.4;margin-bottom:14px;}
        .op-row{display:flex;justify-content:space-between;margin-bottom:5px;}
        .op-lbl{font-size:11px;color:#6b7280;text-transform:uppercase;letter-spacing:.6px;font-weight:600;}
        .op-pct{font-size:12px;color:var(--primary);font-weight:700;}
        .op-bar{height:5px;background:#1f2937;border-radius:4px;overflow:hidden;}
        .op-fill{height:100%;background:var(--primary);border-radius:4px;transition:width .5s ease;}
        .sb-tabs{display:flex;border-bottom:1px solid var(--sb-border);padding:0 20px;}
        .sb-tab{font-size:13px;font-weight:600;color:#6b7280;padding:10px 0;margin-right:20px;cursor:pointer;border-bottom:2px solid transparent;transition:all .2s;}
        .sb-tab.active{color:var(--primary);border-bottom-color:var(--primary);}
        .sb-scroll{flex:1;overflow-y:auto;padding:8px 0 20px;}
        .sb-scroll::-webkit-scrollbar{width:4px;}
        .sb-scroll::-webkit-scrollbar-thumb{background:#374151;border-radius:4px;}
        .mg{margin-bottom:2px;}
        .mh{display:flex;align-items:center;padding:10px 20px;cursor:pointer;color:#d1d5db;font-size:11px;font-weight:700;gap:10px;transition:background .15s;user-select:none;text-transform:uppercase;letter-spacing:.2px;}
        .mh:hover{background:var(--sb-hover);}
        .mn{flex:1;}.mc{font-size:11px;color:#4b5563;font-weight:600;font-style:normal;text-transform:none;}
        .mchev{font-size:10px;color:#4b5563;transition:transform .2s;}
        .mg.col .mchev{transform:rotate(-90deg);}
        .mg.col .ml{display:none;}
        .li{display:flex;align-items:center;padding:9px 18px 9px 20px;cursor:pointer;color:#9ca3af;font-size:13px;gap:10px;transition:background .15s,color .15s;border-left:3px solid transparent;}
        .li:hover{background:var(--sb-hover);color:#e5e7eb;}
        .li.active{background:var(--sb-active);color:#fff;border-left-color:var(--primary);}
        .ls{width:20px;height:20px;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;border:2px solid #374151;font-size:10px;color:transparent;transition:all .3s;}
        .ls.visited{border-color:var(--primary);color:var(--primary);}
        .ls.complete{background:var(--green);border-color:var(--green);color:#fff;}
        .li-info{flex:1;min-width:0;}
        .li-name{white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
        .li-dur{font-size:11px;color:#4b5563;white-space:nowrap;flex-shrink:0;}
        .li.active .li-dur{color:#9ca3af;}
        .sa{display:flex;align-items:center;padding:11px 20px;cursor:pointer;color:#9ca3af;font-size:13px;gap:10px;border-left:3px solid transparent;transition:background .15s,color .15s;}
        .sa:hover{background:var(--sb-hover);color:#e5e7eb;}
        .sa.active{background:var(--sb-active);color:#fff;border-left-color:var(--primary);}
        .sa.cert-sa{color:#fbbf24;}
        .sa.cert-sa:hover{background:rgba(251,191,36,.08);color:#f59e0b;}
        .sa.cert-locked{color:#6b7280;}
        .sa.cert-locked:hover{background:var(--sb-hover);color:#9ca3af;}

        /* ══ MAIN ══ */
        .main{flex:1;display:flex;flex-direction:column;height:100vh;overflow:hidden;background:#fff;}
        .topbar{height:54px;background:#fff;border-bottom:1px solid #e5e7eb;display:flex;align-items:center;padding:0 28px;justify-content:space-between;flex-shrink:0;}
        .tb-title{font-size:15px;font-weight:600;color:var(--text);}
        .tb-right{display:flex;align-items:center;gap:12px;}
        .tb-comp{font-size:13px;font-weight:600;padding:4px 12px;border-radius:20px;background:#f3f4f6;color:var(--muted);transition:all .3s;}
        .tb-comp.done{background:#dcfce7;color:var(--green-d);}
        .tb-save-ind{font-size:12px;font-weight:600;padding:5px 12px;border-radius:20px;display:none;align-items:center;gap:6px;transition:all .3s;}
        .tb-save-ind.saving{display:inline-flex;background:#f3f4f6;color:#6b7280;}
        .tb-save-ind.saved{display:inline-flex;background:#dcfce7;color:#166534;}
        .tb-mc-btn{padding:8px 20px;border-radius:8px;font-size:13px;font-weight:700;cursor:pointer;border:2px solid var(--green);font-family:inherit;background:#fff;color:var(--green-d);display:none;align-items:center;gap:7px;transition:all .2s;}
        .tb-mc-btn:hover{background:var(--green);color:#fff;}
        .tb-mc-btn.show{display:inline-flex;}
        .scroll{flex:1;overflow-y:auto;padding:40px 60px;}
        .scroll::-webkit-scrollbar{width:6px;}
        .scroll::-webkit-scrollbar-thumb{background:#e5e7eb;border-radius:3px;}
        .foot{height:64px;background:#fff;border-top:1px solid #e5e7eb;display:flex;align-items:center;justify-content:space-between;padding:0 28px;flex-shrink:0;}
        .fb{padding:9px 22px;border-radius:8px;font-size:14px;font-weight:600;cursor:pointer;border:none;font-family:inherit;transition:all .2s;}
        .fg{background:transparent;color:var(--muted);border:1.5px solid #e5e7eb;}
        .fg:hover{border-color:#9ca3af;color:var(--text);}
        .fp{background:var(--primary);color:#fff;}
        .fp:hover{background:var(--primary-dark);transform:translateY(-1px);}

        /* ══ LESSON SHARED ══ */
        .lhdr{text-align:center;margin-bottom:30px;padding-bottom:24px;border-bottom:1px solid #f3f4f6;}
        .lhdr h1{font-size:26px;font-weight:800;color:var(--text);margin-bottom:8px;}
        .lmeta{font-size:14px;color:var(--muted);display:flex;align-items:center;justify-content:center;gap:6px;}
        .cbanner{display:flex;align-items:center;justify-content:space-between;background:#f0f9ff;border:1.5px solid rgba(0,153,255,.18);border-radius:10px;padding:14px 20px;margin-bottom:26px;gap:16px;}
        .cb-l{display:flex;align-items:center;gap:12px;}
        .cb-ico{width:36px;height:36px;background:var(--green);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:16px;flex-shrink:0;}
        .cb-t strong{font-size:14px;color:var(--text);display:block;}
        .cb-t span{font-size:13px;color:var(--muted);}
        .cb-undo{background:none;border:1px solid #d1d5db;border-radius:6px;padding:5px 12px;font-size:12px;color:#6b7280;cursor:pointer;font-family:inherit;transition:background .2s;}
        .cb-undo:hover{background:#f3f4f6;}
        .mc-btn{display:inline-flex;align-items:center;gap:8px;padding:11px 24px;background:#fff;border:2px solid var(--green);color:var(--green-d);border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:all .2s;margin-top:30px;}
        .mc-btn:hover{background:var(--green);color:#fff;}

        /* ══ NOTES ══ */
        .np{max-width:760px;margin:0 auto;}
        .lobj{background:#f0f9ff;border:1px solid rgba(0,153,255,.14);border-left:3px solid var(--primary);border-radius:0 12px 12px 0;padding:20px 24px;margin-bottom:26px;}
        .lobj h3{font-size:13px;text-transform:uppercase;letter-spacing:.8px;color:var(--primary);margin-bottom:10px;}
        .lobj ul{list-style:none;display:flex;flex-direction:column;gap:7px;}
        .lobj li{display:flex;align-items:flex-start;gap:10px;font-size:14px;color:var(--text);}
        .lobj li::before{content:'\2713';color:var(--primary);font-weight:700;flex-shrink:0;}
        .ns{margin-bottom:26px;}
        .ns h2{font-size:18px;font-weight:700;color:var(--text);margin-bottom:12px;padding-bottom:10px;border-bottom:2px solid #f3f4f6;display:flex;align-items:center;gap:10px;}
        .si{width:30px;height:30px;border-radius:7px;display:flex;align-items:center;justify-content:center;font-size:13px;color:#fff;background:var(--primary);flex-shrink:0;}
        .ns p{font-size:15px;color:#374151;line-height:1.75;margin-bottom:12px;}
        .cb{background:#0f172a;border-radius:10px;padding:20px 22px;margin:14px 0;overflow-x:auto;position:relative;}
        .cl{position:absolute;top:10px;right:14px;font-size:11px;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:.5px;}
        .cb pre{margin:0;font-family:'Consolas','Courier New',monospace;font-size:14px;line-height:1.7;color:#d1d5db;}
        .kw{color:#b39ddb;}.fn{color:#90caf9;}.st{color:#80cbc4;}.nm{color:#ffcc80;}.cm{color:#607d8b;font-style:italic;}.bl{color:#f48fb1;}
        .ig{display:grid;grid-template-columns:repeat(auto-fill,minmax(170px,1fr));gap:12px;margin:14px 0;}
        .ic{background:#fff;border:1px solid #e5e7eb;border-top:2px solid var(--primary);border-radius:10px;padding:14px;transition:box-shadow .2s;}
        .ic:hover{box-shadow:0 4px 12px rgba(0,153,255,.1);}
        .ict{font-size:11px;text-transform:uppercase;letter-spacing:.6px;color:var(--primary);font-weight:600;margin-bottom:5px;}
        .icv{font-family:'Consolas',monospace;font-size:14px;color:#374151;font-weight:600;}
        .icd{font-size:12px;color:var(--muted);margin-top:3px;}
        .tip{background:#f0f9ff;border-left:3px solid var(--primary);border-radius:0 10px 10px 0;padding:13px 18px;margin:14px 0;}
        .tip strong{color:var(--primary-dark);font-size:13px;}.tip p{margin:4px 0 0;font-size:14px;color:#374151;}

        /* ══ QUIZ ══ */
        .qp{max-width:680px;margin:0 auto;}
        .q-attempt-bar{display:flex;align-items:center;justify-content:space-between;background:#f9fafb;border:1.5px solid #e5e7eb;border-radius:10px;padding:12px 18px;margin-bottom:20px;}
        .qa-label{font-size:13px;font-weight:700;color:var(--text);}
        .qa-dots{display:flex;gap:8px;}
        .qa-dot{width:28px;height:28px;border-radius:50%;border:2px solid #e5e7eb;display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:700;color:#9ca3af;transition:all .3s;}
        .qa-dot.used-fail{background:#fee2e2;border-color:var(--red);color:var(--red);}
        .qa-dot.used-pass{background:#dcfce7;border-color:var(--green);color:var(--green-d);}
        .qa-dot.current{background:rgba(0,153,255,.1);border-color:#0099ff;color:#007acc;}
        .qbar-wrap{width:100%;background:#e9ecef;border-radius:10px;height:8px;overflow:hidden;margin-bottom:14px;}
        .qbar-fill{height:100%;background:var(--primary);border-radius:10px;transition:width .4s ease;}
        .qbadge{display:inline-block;background:var(--primary);color:#fff;padding:4px 14px;border-radius:20px;font-size:13px;font-weight:600;margin-bottom:8px;}
        .qtext{font-size:17px;font-weight:600;color:var(--text);margin-bottom:14px;line-height:1.5;}
        .qopts{display:flex;flex-direction:column;gap:8px;margin-bottom:12px;}
        .qopt{display:flex;align-items:center;gap:14px;padding:10px 16px;border:2px solid #e5e7eb;border-radius:10px;cursor:pointer;font-size:15px;color:#374151;transition:all .18s;position:relative;}
        .qopt:hover{border-color:var(--primary);background:#f0f9ff;}
        .qopt.sel{border-color:var(--primary);background:#f0f9ff;}
        .qopt.correct{border-color:var(--green);background:#f0fdf4;color:#166534;}
        .qopt.wrong{border-color:var(--red);background:#fef2f2;color:#991b1b;}
        .qopt input[type=radio]{accent-color:var(--primary);width:17px;height:17px;flex-shrink:0;}
        .qopt .oc{position:absolute;right:14px;font-size:14px;display:none;}
        .qopt.correct .oc{display:block;color:var(--green);}
        .qopt.wrong .oc{display:block;color:var(--red);}
        .qnav{display:flex;justify-content:space-between;align-items:center;}
        .qbtn{padding:10px 24px;border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;border:none;font-family:inherit;transition:all .2s;}
        .q-skip{background:#f3f4f6;color:#6b7280;border:1.5px solid #e5e7eb;}
        .q-skip:hover{background:#e5e7eb;}
        .q-next{background:var(--primary);color:#fff;}
        .q-next:hover{background:var(--primary-dark);transform:translateY(-1px);}
        .q-fin{background:#16a34a;color:#fff;display:flex;align-items:center;}
        .q-fin:hover{background:#15803d;}
        .qtracker{display:flex;justify-content:space-around;margin-top:10px;padding:10px 14px;background:#f9fafb;border-radius:10px;border:1px solid #e5e7eb;}
        .qti{text-align:center;}
        .qtl{font-size:11px;text-transform:uppercase;color:#9ca3af;font-weight:600;letter-spacing:.5px;display:block;margin-bottom:2px;}
        .qtv{font-size:20px;font-weight:800;color:var(--text);}
        .qwarn{color:var(--red);font-size:13px;font-weight:600;margin-top:8px;min-height:18px;}

        /* Quiz Result */
        .qresult{display:none;text-align:center;}
        .qr-ring{width:140px;height:140px;border-radius:50%;border:8px solid #e5e7eb;margin:0 auto 18px;display:flex;flex-direction:column;align-items:center;justify-content:center;}
        .qr-ring.pass{border-color:var(--green);}
        .qr-ring.fail{border-color:var(--red);}
        .qr-pct{font-size:38px;font-weight:900;line-height:1;}
        .qr-pct.pass{color:var(--green-d);}
        .qr-pct.fail{color:var(--red);}
        .qr-plbl{font-size:12px;color:var(--muted);font-weight:600;margin-top:2px;}
        .qr-badge{display:inline-flex;align-items:center;gap:8px;padding:6px 20px;border-radius:20px;font-size:14px;font-weight:700;margin-bottom:10px;}
        .qr-badge.pass{background:#dcfce7;color:#166534;}
        .qr-badge.fail{background:#fee2e2;color:#991b1b;}
        .qr-msg{font-size:15px;color:#374151;max-width:480px;margin:0 auto 24px;line-height:1.6;}
        .qr-stats{display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-bottom:24px;max-width:480px;margin-left:auto;margin-right:auto;}
        .qr-stat{background:#f9fafb;border:1px solid #e5e7eb;border-radius:10px;padding:14px;}
        .qr-stats .qr-stat:nth-child(1){background:#f0fdf4;border-color:#bbf7d0;}
        .qr-stats .qr-stat:nth-child(1) .qr-sv{color:#16a34a;}
        .qr-stats .qr-stat:nth-child(2){background:#fef2f2;border-color:#fecaca;}
        .qr-stats .qr-stat:nth-child(2) .qr-sv{color:#dc2626;}
        .qr-stats .qr-stat:nth-child(3){background:#eff6ff;border-color:#bfdbfe;}
        .qr-stats .qr-stat:nth-child(3) .qr-sv{color:var(--primary);}
        .qr-sv{font-size:26px;font-weight:800;color:var(--text);}
        .qr-sl{font-size:12px;color:var(--muted);margin-top:2px;}
        .qr-bd{text-align:left;background:#fff;border-radius:12px;padding:16px 20px;margin-bottom:24px;border:1px solid #e5e7eb;}
        .qr-bd h4{font-size:14px;font-weight:700;color:var(--text);margin-bottom:12px;display:flex;align-items:center;gap:8px;}
        .qr-qi{padding:12px;border-bottom:none;border-radius:10px;margin-bottom:6px;}
        .qr-qi:last-child{margin-bottom:0;}
        .qr-qi-c{background:#f0fdf4;border:1.5px solid #bbf7d0;}
        .qr-qi-w{background:#fff5f5;border:1.5px solid #fecaca;}
        .qr-qi-s{background:#f9fafb;border:1.5px solid #e5e7eb;}
        .qr-qi-top{display:flex;align-items:flex-start;gap:12px;}
        .qr-ico{width:22px;height:22px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:11px;color:#fff;flex-shrink:0;margin-top:2px;}
        .qr-ico.c{background:var(--green);} .qr-ico.w{background:var(--red);} .qr-ico.s{background:#9ca3af;}
        .qr-qtxt{font-size:14px;color:var(--text);font-weight:600;line-height:1.4;flex:1;}
        .qr-ans{font-size:13px;margin-top:6px;padding:8px 12px;border-radius:8px;line-height:1.5;}
        .qr-ans.correct{background:#f0fdf4;color:#166534;border-left:3px solid var(--green);}
        .qr-ans.wrong{background:#fef2f2;color:#991b1b;border-left:3px solid var(--red);}
        .qr-ans.skipped{background:#f9fafb;color:var(--muted);border-left:3px solid #9ca3af;}
        .qr-exp{font-size:13px;color:#92400e;margin-top:8px;padding:10px 14px;background:#fffbeb;border-left:3px solid #fbbf24;border-radius:0 8px 8px 0;line-height:1.6;}
        .qr-exp strong{color:#78350f;}
        .qr-acts{display:flex;gap:12px;justify-content:center;flex-wrap:wrap;}
        .qr-btn{padding:11px 26px;border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;border:none;font-family:inherit;transition:all .2s;display:inline-flex;align-items:center;gap:8px;}
        .qr-retry{background:#f3f4f6;color:var(--text);border:1.5px solid #e5e7eb;}
        .qr-retry:hover{background:#e5e7eb;}
        .qr-cert{background:#d97706;color:#fff;display:none;}
        .qr-cert:hover{background:#b45309;transform:translateY(-1px);}
        .qr-locked-msg{background:#fef2f2;border:1.5px solid #fca5a5;border-radius:10px;padding:18px 22px;text-align:center;margin-bottom:20px;}
        .qr-locked-msg h3{color:#991b1b;font-size:16px;margin-bottom:6px;}
        .qr-locked-msg p{color:#7f1d1d;font-size:14px;}

        /* Quiz Locked State */
        .q-locked-panel{background:#fef2f2;border:2px solid #fca5a5;border-radius:14px;padding:40px 30px;text-align:center;}
        .q-locked-ico{width:70px;height:70px;border-radius:50%;background:#fee2e2;display:flex;align-items:center;justify-content:center;font-size:28px;color:var(--red);margin:0 auto 18px;}
        .q-locked-panel h2{font-size:20px;font-weight:800;color:#991b1b;margin-bottom:10px;}
        .q-locked-panel p{font-size:14px;color:#7f1d1d;line-height:1.6;max-width:380px;margin:0 auto 20px;}
        .q-locked-score{display:inline-flex;align-items:center;gap:8px;padding:8px 20px;background:#fee2e2;color:#991b1b;border-radius:20px;font-size:14px;font-weight:700;margin-bottom:20px;}
        .q-review-btn{padding:10px 22px;background:#f3f4f6;color:var(--text);border:1.5px solid #e5e7eb;border-radius:8px;font-size:14px;font-weight:600;cursor:pointer;font-family:inherit;transition:all .2s;}
        .q-review-btn:hover{background:#e5e7eb;}

        /* ══ DISCUSSION ══ */
        .dp{max-width:720px;margin:0 auto;}
        .dpost{background:#fff;border:1px solid #e5e7eb;border-radius:12px;padding:20px;margin-bottom:14px;transition:box-shadow .2s;}
        .dpost:hover{box-shadow:0 4px 12px rgba(0,0,0,.06);}
        .ph{display:flex;align-items:center;gap:12px;margin-bottom:12px;}
        .pav{width:40px;height:40px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:15px;font-weight:700;color:#fff;flex-shrink:0;}
        .pm .pa{font-size:14px;font-weight:700;color:var(--text);}
        .pm .pt{font-size:12px;color:var(--muted);margin-top:2px;}
        .pb{font-size:14px;color:#374151;line-height:1.7;}
        .pb code{background:#f3f4f6;padding:2px 6px;border-radius:4px;font-family:'Consolas',monospace;font-size:13px;color:var(--primary);}
        .pacts{display:flex;gap:14px;margin-top:12px;}
        .pab{background:none;border:none;font-size:13px;color:var(--muted);cursor:pointer;display:flex;align-items:center;gap:5px;padding:4px 8px;border-radius:6px;font-family:inherit;transition:all .15s;}
        .pab:hover{background:#f3f4f6;color:var(--text);}
        .pab.liked{color:var(--primary);}
        .preps{margin-top:14px;padding-top:14px;border-top:1px solid #f3f4f6;display:flex;flex-direction:column;gap:10px;}
        .rrow{display:flex;gap:10px;}
        .rav{width:30px;height:30px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:700;color:#fff;flex-shrink:0;}
        .rbub{background:#f9fafb;border-radius:0 10px 10px 10px;padding:10px 14px;flex:1;}
        .rbub .ra{font-size:13px;font-weight:700;color:var(--text);margin-bottom:3px;}
        .rbub p{font-size:13px;color:#374151;margin:0;line-height:1.6;}
        .npbox{background:#f9fafb;border:1.5px solid #e5e7eb;border-radius:12px;padding:20px;margin-top:18px;}
        .npbox h3{font-size:15px;font-weight:700;color:var(--text);margin-bottom:12px;display:flex;align-items:center;gap:8px;}
        .npbox textarea{width:100%;padding:12px 14px;border:1.5px solid #e5e7eb;border-radius:8px;font-family:inherit;font-size:14px;color:var(--text);background:#fff;resize:vertical;min-height:88px;transition:border-color .2s;outline:none;}
        .npbox textarea:focus{border-color:var(--primary);box-shadow:0 0 0 3px rgba(0,153,255,.1);}
        .psr{display:flex;justify-content:flex-end;margin-top:10px;}
        .psub{padding:9px 22px;background:var(--primary);color:#fff;border:none;border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:all .2s;}
        .psub:hover{background:var(--primary-dark);transform:translateY(-1px);}

        /* ══ PLACE / CERT PANELS ══ */
        .pp{max-width:700px;margin:0 auto;}
        .pcard{background:#f9fafb;border-radius:16px;padding:60px 40px;text-align:center;border:1px solid #e5e7eb;}
        .pico{width:80px;height:80px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:32px;margin:0 auto 20px;}
        .pcard p{color:var(--muted);font-size:14px;line-height:1.7;max-width:420px;margin:0 auto 22px;}
        .plaunch{display:inline-flex;align-items:center;gap:8px;padding:11px 24px;background:var(--primary);color:#fff;border:none;border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:all .2s;}
        .plaunch:hover{background:var(--primary-dark);transform:translateY(-1px);}
        .cert-lk-card{background:#f9fafb;border-radius:16px;padding:50px 40px;text-align:center;border:1px solid #e5e7eb;}
        .clk-ico{width:78px;height:78px;border-radius:50%;background:rgba(0,153,255,.08);display:flex;align-items:center;justify-content:center;font-size:30px;color:var(--primary);margin:0 auto 20px;border:2px solid rgba(0,153,255,.16);}
        .cert-lk-card h2{font-size:22px;font-weight:800;color:var(--text);margin-bottom:8px;}
        .cert-lk-card p{color:var(--muted);font-size:14px;max-width:360px;margin:0 auto 22px;line-height:1.6;}
        .req-list{list-style:none;text-align:left;max-width:340px;margin:0 auto 26px;display:flex;flex-direction:column;gap:10px;}
        .req-li{display:flex;align-items:center;gap:12px;font-size:14px;color:#374151;padding:12px 16px;background:#fff;border-radius:8px;border:1.5px solid #e5e7eb;}
        .req-ico{width:24px;height:24px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:11px;flex-shrink:0;}
        .req-ico.done{background:var(--green);color:#fff;}
        .req-ico.pend{background:#e5e7eb;color:#9ca3af;}
        .cert-goto{display:inline-flex;align-items:center;gap:8px;padding:11px 24px;background:var(--primary);color:#fff;border:none;border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:all .2s;}
        .cert-goto:hover{background:var(--primary-dark);transform:translateY(-1px);}
        .cert-ul-card{background:#fff;border-radius:16px;overflow:hidden;border:1px solid #e5e7eb;box-shadow:0 4px 20px rgba(0,0,0,.06);}
        .cert-ul-header{background:var(--primary);padding:36px 40px 26px;text-align:center;}
        .cert-ul-icon{width:62px;height:62px;border-radius:50%;background:rgba(255,255,255,.15);border:2px solid rgba(255,255,255,.28);display:flex;align-items:center;justify-content:center;font-size:24px;color:#fff;margin:0 auto 14px;}
        .cert-ul-header h2{font-size:22px;font-weight:800;color:#fff;margin:0 0 6px;}
        .cert-ul-header p{color:rgba(255,255,255,.8);font-size:13px;margin:0;}
        #panel-cert-unlocked .cert-ul-header{background:var(--primary);}
        #panel-cert-unlocked .cert-score-b{background:rgba(0,153,255,.08);color:#007acc;border-color:rgba(0,153,255,.22);}
        .cert-ul-body{padding:26px 40px 32px;text-align:center;}
        .cert-ul-body > p{font-size:14px;color:var(--muted);margin:14px auto 22px;line-height:1.6;max-width:400px;}
        .cert-score-b{display:inline-flex;align-items:center;gap:8px;padding:6px 18px;background:rgba(0,153,255,.08);color:#007acc;border:1px solid rgba(0,153,255,.22);border-radius:20px;font-size:14px;font-weight:700;}
        .cert-get{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;background:var(--primary);color:#fff;border:none;border-radius:8px;font-size:15px;font-weight:700;cursor:pointer;font-family:inherit;transition:all .2s;}
        .cert-get:hover{background:var(--primary-dark);transform:translateY(-1px);}

        /* Saving indicator */
        .saving-toast{position:fixed;bottom:24px;right:24px;background:#111827;color:#fff;padding:10px 18px;border-radius:8px;font-size:13px;font-weight:600;display:none;align-items:center;gap:8px;z-index:9999;box-shadow:0 4px 16px rgba(0,0,0,.3);}
        .saving-toast.show{display:flex;}
        .saving-toast.saved{background:#16a34a;}

        /* ══ VIRTUAL LAB ══ */
        .lab-wrap{max-width:700px;margin:0 auto;}
        .lab-prog-row{display:flex;justify-content:space-between;align-items:center;margin-bottom:6px;}
        .lab-prog-lbl{font-size:13px;color:var(--muted);font-weight:600;}
        .lab-prog-bar{height:6px;background:#e5e7eb;border-radius:4px;overflow:hidden;margin-bottom:22px;}
        .lab-prog-fill{height:100%;background:var(--primary);border-radius:4px;transition:width .4s;}
        .lab-task-card{background:#f9fafb;border:1.5px solid #e5e7eb;border-radius:12px;padding:20px 24px;margin-bottom:18px;}
        .lab-task-num{font-size:11px;text-transform:uppercase;letter-spacing:.8px;color:#6b7280;font-weight:700;margin-bottom:8px;}
        .lab-task-q{font-size:16px;font-weight:600;color:var(--text);line-height:1.55;}
        .lab-hint{font-size:13px;color:var(--muted);margin-top:8px;font-style:italic;}
        .lab-code-lbl{font-size:13px;font-weight:700;color:var(--text);margin-bottom:6px;display:flex;align-items:center;gap:6px;}
        .lab-code-area{width:100%;min-height:120px;padding:14px 16px;background:#0f172a;color:#e2e8f0;border:2px solid #374151;border-radius:10px;font-family:'Consolas','Courier New',monospace;font-size:14px;line-height:1.7;resize:vertical;outline:none;transition:border-color .2s;tab-size:4;}
        .lab-code-area:focus{border-color:var(--primary);}
        .lab-code-area::placeholder{color:#475569;}
        .lab-reveal-btn{display:inline-flex;align-items:center;gap:8px;margin-top:12px;padding:10px 22px;background:#fff;border:2px solid var(--primary);color:var(--primary);border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:all .2s;}
        .lab-reveal-btn:hover{background:var(--primary);color:#fff;}
        .lab-answer{display:none;margin-top:16px;border:1.5px solid #d1d5db;border-radius:12px;overflow:hidden;}
        .lab-ans-hdr{background:#f3f4f6;padding:10px 16px;font-size:13px;font-weight:700;color:#374151;display:flex;align-items:center;gap:8px;}
        .lab-ans-code{background:#0f172a;padding:16px 18px;margin:0;font-family:'Consolas','Courier New',monospace;font-size:14px;line-height:1.7;color:#d1d5db;white-space:pre;overflow-x:auto;}
        .lab-ans-exp{background:#f9fafb;padding:12px 16px;font-size:13px;color:#374151;line-height:1.6;border-top:1px solid #e5e7eb;}
        .lab-nav{display:flex;gap:12px;justify-content:space-between;align-items:center;margin-top:20px;}
        .lab-got{padding:10px 22px;background:var(--green-d);color:#fff;border:none;border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;display:inline-flex;align-items:center;gap:8px;transition:all .2s;}
        .lab-got:hover{background:#15803d;transform:translateY(-1px);}
        .lab-retry{padding:10px 22px;background:#f3f4f6;color:var(--text);border:1.5px solid #e5e7eb;border-radius:8px;font-size:14px;font-weight:600;cursor:pointer;font-family:inherit;transition:all .2s;}
        .lab-retry:hover{background:#e5e7eb;}
        .lab-done-card{text-align:center;background:#fff;border:1.5px solid #e5e7eb;border-radius:16px;padding:50px 40px;box-shadow:0 4px 16px rgba(0,0,0,.05);}
        .lab-done-ico{font-size:54px;margin-bottom:14px;}
        .lab-done-card h2{font-size:22px;font-weight:800;color:var(--text);margin-bottom:8px;}
        .lab-done-card p{color:var(--muted);font-size:14px;margin-bottom:22px;}
        .lab-score-b{display:inline-flex;align-items:center;gap:8px;padding:6px 18px;background:#f3f4f6;color:#374151;border-radius:20px;font-size:14px;font-weight:700;margin-bottom:18px;border:1.5px solid #e5e7eb;}
        .lab-restart{padding:10px 22px;background:#fff;border:2px solid var(--primary);color:var(--primary);border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:all .2s;}
        .lab-restart:hover{background:var(--primary);color:#fff;}
        .lab-check-btn{display:inline-flex;align-items:center;gap:8px;padding:10px 22px;background:var(--primary);color:#fff;border:none;border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:all .2s;}
        .lab-check-btn:hover{background:var(--primary-dark);transform:translateY(-1px);}
        .lab-status{padding:12px 16px;border-radius:10px;font-size:14px;font-weight:600;display:flex;align-items:center;gap:10px;margin-bottom:14px;}
        .lab-status.correct{background:#dcfce7;color:#166534;border:1.5px solid #86efac;}
        .lab-status.wrong{background:#fee2e2;color:#991b1b;border:1.5px solid #fca5a5;}
        .lab-retype-msg{padding:10px 16px;background:#f9fafb;border:1.5px solid #d1d5db;border-radius:8px;font-size:13px;color:#6b7280;display:flex;align-items:center;gap:8px;margin-top:10px;}

        /* ══ BRAND HEADER ══ */
        .sb-brand{padding:14px 20px;border-bottom:1px solid var(--sb-border);display:flex;align-items:center;gap:12px;flex-shrink:0;cursor:pointer;transition:background .2s;user-select:none;}
        .sb-brand:hover{background:rgba(255,255,255,.06);}
        .sb-back-arrow{font-size:11px;color:#4b5563;flex-shrink:0;transition:color .2s;}
        .sb-brand:hover .sb-back-arrow{color:#9ca3af;}
        .sb-brand-logo{width:38px;height:38px;border-radius:50%;object-fit:cover;border:2px solid var(--primary);flex-shrink:0;}
        .sb-brand-name{font-size:15px;font-weight:700;color:#fff;letter-spacing:.3px;line-height:1.2;}
        .sb-brand-sub{font-size:11px;color:#6b7280;margin-top:2px;}

        /* ══ CYBERSECURITY COURSE BADGE ══ */
        .course-lang-badge{display:inline-flex;align-items:center;gap:6px;background:rgba(0,153,255,.1);border:1px solid rgba(0,153,255,.22);border-radius:6px;padding:3px 9px;font-size:11px;font-weight:700;color:var(--primary);margin-top:8px;letter-spacing:.3px;}

        /* ══ TOPBAR USER CHIP ══ */
        .tb-user{display:inline-flex;align-items:center;gap:8px;padding:4px 12px 4px 4px;border-radius:20px;background:#f3f4f6;font-size:13px;font-weight:600;color:var(--text);border:1px solid #e5e7eb;cursor:pointer;transition:background .15s;}
        .tb-user:hover{background:#e5e7eb;}
        .tb-user-av{width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,var(--primary),var(--primary-dark));display:flex;align-items:center;justify-content:center;font-size:11px;color:#fff;font-weight:700;flex-shrink:0;}

        /* ══ USER DROPDOWN MENU ══ */
        .um-wrap{position:relative;}
        .user-menu{display:none;position:absolute;top:calc(100% + 8px);right:0;background:#fff;border:1px solid #e5e7eb;border-radius:12px;box-shadow:0 8px 28px rgba(0,0,0,.12);padding:6px;min-width:220px;z-index:500;}
        .um-header{display:flex;align-items:center;gap:10px;padding:8px 10px 10px;}
        .um-av{width:34px;height:34px;border-radius:50%;background:linear-gradient(135deg,var(--primary),var(--primary-dark));display:flex;align-items:center;justify-content:center;font-size:12px;color:#fff;font-weight:700;flex-shrink:0;}
        .um-info .um-name{font-size:14px;font-weight:700;color:var(--text);}
        .um-info .um-role{font-size:11px;color:var(--muted);margin-top:1px;}
        .um-divider{height:1px;background:#f3f4f6;margin:2px 0 4px;}
        .um-btn{width:100%;text-align:left;padding:9px 12px;border-radius:8px;font-size:13px;font-weight:600;cursor:pointer;border:none;font-family:inherit;display:flex;align-items:center;gap:9px;transition:background .15s;background:none;color:var(--text);}
        .um-reset i{color:#9ca3af;transition:color .15s;}
        .um-reset:hover{background:#fef2f2;color:#dc2626;}
        .um-reset:hover i{color:#dc2626;}
        .um-warn{font-size:12px;color:#7f1d1d;background:#fef2f2;border:1px solid #fecaca;border-radius:8px;padding:9px 11px;margin:4px 2px 8px;line-height:1.55;}
        .um-confirm-row{display:flex;gap:6px;padding:0 2px 2px;}
        .um-confirm{background:#dc2626;color:#fff;flex:1;justify-content:center;}
        .um-confirm:hover{background:#b91c1c;}
        .um-confirm:disabled{opacity:.6;cursor:not-allowed;}
        .um-cancel{background:#f3f4f6;color:var(--text);flex:1;justify-content:center;border:1.5px solid #e5e7eb;}
        .um-cancel:hover{background:#e5e7eb;}
    </style>
</head>
<body>
<form id="form1" runat="server" style="display:contents;">

    <!-- ═══ SIDEBAR ═══ -->
    <div class="sb">
        <!-- Brand Header — click to go back to My Courses -->
        <div class="sb-brand" onclick="document.getElementById('<%= btnback.ClientID %>').click()" title="Back to My Courses">
            <i class="fa-solid fa-chevron-left sb-back-arrow"></i>
            <img src="images/netguard_logo.png" alt="NetGuard" class="sb-brand-logo" />
            <div>
                <div class="sb-brand-name">NetGuard</div>
                <div class="sb-brand-sub">Learning Platform</div>
            </div>
            <asp:Button ID="btnback" runat="server" OnClick="btnback_Click" CausesValidation="false" style="display:none;" />
        </div>
        <div class="sb-top">
            <div class="sb-title"><asp:Label ID="lblCourseTitle" runat="server" Text="CyberSecurity Basics"></asp:Label></div>
            <div class="op-row"><span class="op-lbl">Progress</span><span class="op-pct" id="opPct">0%</span></div>
            <div class="op-bar"><div class="op-fill" id="opFill" style="width:0%"></div></div>
        </div>
        <div class="sb-tabs"><div class="sb-tab active">Course Outline</div></div>
        <div class="sb-scroll">
            <!-- Module 1 -->
            <div class="mg" id="mod1">
                <div class="mh" onclick="toggleMod('mod1')">
                    <span class="mn">Module 1: Foundations &amp; Threats</span>
                    <em class="mc" id="m1c">0 / 3</em>
                    <i class="fa-solid fa-chevron-down mchev"></i>
                </div>
                <div class="ml">
                    <div class="li active" id="li-intro" onclick="go(this,'intro')"><div class="ls" id="st-intro"><i class="fa-solid fa-check"></i></div><div class="li-info"><div class="li-name">Foundations &amp; Threats</div></div><span class="li-dur">15 min</span></div>
                    <div class="li" id="li-auth"  onclick="go(this,'auth')"> <div class="ls" id="st-auth"><i class="fa-solid fa-check"></i></div><div class="li-info"><div class="li-name">Authentication &amp; Encryption</div></div><span class="li-dur">18 min</span></div>
                    <div class="li" id="li-best"  onclick="go(this,'best')"> <div class="ls" id="st-best"><i class="fa-solid fa-check"></i></div><div class="li-info"><div class="li-name">Security Best Practices</div></div><span class="li-dur">20 min</span></div>
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
                    <div class="li" id="li-labs" onclick="go(this,'labs')"><div class="ls" id="st-labs"><i class="fa-solid fa-check"></i></div><div class="li-info"><div class="li-name">Interactive Sandbox &mdash; Security Labs</div></div><span class="li-dur">30 min</span></div>
                    <div class="li" id="li-quiz" onclick="go(this,'quiz')"><div class="ls" id="st-quiz"><i class="fa-solid fa-check"></i></div><div class="li-info"><div class="li-name">Self-Assessment Quiz</div></div><span class="li-dur">20 min</span></div>
                    <div class="li" id="li-disc" onclick="go(this,'disc')"><div class="ls" id="st-disc"><i class="fa-solid fa-check"></i></div><div class="li-info"><div class="li-name">Discussion Forum</div></div><span class="li-dur">Open</span></div>
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
    </div>

    <!-- ═══ MAIN ═══ -->
    <div class="main">
        <div class="topbar">
            <span class="tb-title" id="tbTitle">1.0: Foundations &amp; Threats</span>
            <div class="tb-right">
                <span class="tb-comp" id="tbComp">0 of 6 completed</span>
                <span class="tb-save-ind" id="tbSaveInd"></span>
                <div class="um-wrap" id="userMenuWrap">
                    <div class="tb-user" id="tbUser" onclick="toggleUserMenu()">
                        <div class="tb-user-av" id="tbUserAv"><i class="fa-solid fa-user"></i></div>
                        <span id="tbUserName">Guest</span>
                        <i class="fa-solid fa-chevron-down" id="umChevron" style="font-size:9px;color:#9ca3af;margin-left:1px;transition:transform .2s;"></i>
                    </div>
                    <div class="user-menu" id="userMenu">
                        <div class="um-header">
                            <div class="um-av" id="umAv"><i class="fa-solid fa-user"></i></div>
                            <div class="um-info">
                                <div class="um-name" id="umName">Guest</div>
                                <div class="um-role">Course Member</div>
                            </div>
                        </div>
                        <div class="um-divider"></div>
                        <div id="umResetDefault">
                            <button type="button" class="um-btn um-reset" onclick="showResetConfirm()">
                                <i class="fa-solid fa-rotate-left"></i> Reset My Progress
                            </button>
                        </div>
                        <div id="umResetConfirm" style="display:none;">
                            <p class="um-warn"><i class="fa-solid fa-triangle-exclamation"></i> This will erase all lesson progress and quiz attempts for this course.</p>
                            <div class="um-confirm-row">
                                <button type="button" class="um-btn um-confirm" onclick="doReset()"><i class="fa-solid fa-rotate-left"></i> Yes, Reset</button>
                                <button type="button" class="um-btn um-cancel" onclick="hideResetConfirm()">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="scroll" id="mainScroll">

            <!-- ── 1.0 Foundations & Threats ── -->
            <div id="panel-intro" class="np">
                <div id="bn-intro"></div>
                <div class="lhdr"><h1>Foundations &amp; Threats</h1><div class="lmeta"><i class="fa-solid fa-clock"></i> 15 min &nbsp;&middot;&nbsp; <i class="fa-solid fa-signal"></i> Beginner</div></div>
                <div class="lobj"><h3><i class="fa-solid fa-bullseye"></i>&nbsp; Learning Objectives</h3><ul><li>Understand core cybersecurity concepts and the CIA Triad</li><li>Recognize common threat vectors and malware types</li><li>Learn how vulnerabilities are exploited by threat actors</li><li>Understand why proactive security measures are crucial</li></ul></div>

                <!-- Video Lecture -->
                <div style="margin-bottom:26px;">
                    <h2 style="font-size:18px;font-weight:700;color:var(--text);margin-bottom:12px;padding-bottom:10px;border-bottom:2px solid #f3f4f6;display:flex;align-items:center;gap:10px;">
                        <div class="si"><i class="fa-brands fa-youtube"></i></div> Video Lecture
                    </h2>
                    <div style="position:relative;padding-bottom:56.25%;height:0;overflow:hidden;border-radius:12px;box-shadow:0 4px 20px rgba(0,0,0,.12);">
                        <iframe src="https://www.youtube.com/embed/zYLkdT731x8"
                                title="Introduction to Cybersecurity"
                                style="position:absolute;top:0;left:0;width:100%;height:100%;border:0;"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                allowfullscreen></iframe>
                    </div>
                    <p style="font-size:13px;color:var(--muted);margin-top:8px;"><i class="fa-brands fa-youtube" style="color:#ef4444;"></i> <strong>Cybersecurity Basics Tutorial</strong> &nbsp;&middot;&nbsp; Simply Learn &nbsp;&middot;&nbsp; 12 mins</p>
                </div>

                <div class="ns"><h2><div class="si"><i class="fa-solid fa-shield-halved"></i></div> What is Cybersecurity?</h2>
                <p>Cybersecurity is the discipline and practice of securing computers, servers, mobile devices, electronic systems, networks, and data from unauthorized access, modification, or malicious digital attacks. Modern environments rely on three core principles collectively known as the <strong>CIA Triad</strong>.</p>
                <div class="ig"><div class="ic"><div class="ict">Confidentiality</div><div class="icv">Encryption</div><div class="icd">Keep data hidden from unauthorized eyes</div></div><div class="ic"><div class="ict">Integrity</div><div class="icv">Hashing</div><div class="icd">Ensure data is accurate and untampered</div></div><div class="ic"><div class="ict">Availability</div><div class="icv">Redundancy</div><div class="icd">Keep resources up and fully functional</div></div><div class="ic"><div class="ict">Core Goal</div><div class="icv">Risk Mitigation</div><div class="icd">Minimize threat exposure and impact</div></div></div></div>
                <div class="ns"><h2><div class="si"><i class="fa-solid fa-skull-crossbones"></i></div> Common Cybersecurity Threats</h2>
                <div class="cb"><span class="cl">Attack Types</span><pre><span class="cm"># 1. Phishing: Deceptive emails mimicking legitimate institutions</span>
<span class="fn">Malware</span> = ["Ransomware", "Spyware", "Adware", "Trojan"]
<span class="cm"># 2. DDoS: Overwhelming online services with synthetic traffic</span>
<span class="fn">SQL_Injection</span> = "Inserting malicious payload inside inputs to dump databases"</pre></div>
                <div class="tip"><strong><i class="fa-solid fa-lightbulb" style="color:var(--amber);"></i> Pro Tip:</strong><p>Security is only as strong as its weakest link. In most corporate and personal setups, the human element is targeted first via social engineering.</p></div></div>
            </div>

            <!-- ── 1.1 Authentication & Encryption ── -->
            <div id="panel-auth" class="np" style="display:none;">
                <div id="bn-auth"></div>
                <div class="lhdr"><h1>Authentication &amp; Encryption</h1><div class="lmeta"><i class="fa-solid fa-clock"></i> 18 min &nbsp;&middot;&nbsp; <i class="fa-solid fa-signal"></i> Beginner</div></div>
                <div class="lobj"><h3><i class="fa-solid fa-bullseye"></i>&nbsp; Learning Objectives</h3><ul><li>Understand the difference between authentication and authorization</li><li>Implement Multi-Factor Authentication (MFA)</li><li>Differentiate between Symmetric and Asymmetric encryption</li><li>Understand key distribution and hashing functions</li></ul></div>
                <div class="ns"><h2><div class="si"><i class="fa-solid fa-key"></i></div> Authentication vs. Authorization</h2>
                <p>Authentication confirms <strong>who you are</strong> (using credentials, biometrics, tokens). Authorization determines <strong>what you are permitted to do</strong> (using read/write permissions, access lists).</p>
                <div class="cb"><span class="cl">Authentication Verification</span><pre><span class="kw">def</span> <span class="fn">verify_user</span>(user_pwd, stored_hash):
    <span class="kw">return</span> <span class="fn">hash_function</span>(user_pwd) == stored_hash <span class="cm"># Verify credentials securely</span></pre></div></div>
                <div class="ns"><h2><div class="si"><i class="fa-solid fa-lock"></i></div> Symmetric &amp; Asymmetric Encryption</h2>
                <div class="ig"><div class="ic"><div class="ict">Symmetric</div><div class="icv">AES / DES</div><div class="icd">Same single key for locking and unlocking</div></div><div class="ic"><div class="ict">Asymmetric</div><div class="icv">RSA / ECC</div><div class="icd">Public key encrypts, Private key decrypts</div></div><div class="ic"><div class="ict">Hashing</div><div class="icv">SHA-256</div><div class="icd">One-way conversion to check data integrity</div></div><div class="ic"><div class="ict">MFA</div><div class="icv">OTP / Bio</div><div class="icd">Requires 2+ independent factors to login</div></div></div>
                <div class="cb"><span class="cl">Encryption Example</span><pre>plaintext = <span class="st">"SecretData"</span>
encrypted = <span class="fn">encrypt</span>(plaintext, public_key)
decrypted = <span class="fn">decrypt</span>(encrypted, private_key)
<span class="fn">print</span>(decrypted) <span class="cm"># Output: SecretData</span></pre></div></div>
            </div>

            <!-- ── 1.2 Security Best Practices ── -->
            <div id="panel-best" class="np" style="display:none;">
                <div id="bn-best"></div>
                <div class="lhdr"><h1>Security Best Practices</h1><div class="lmeta"><i class="fa-solid fa-clock"></i> 20 min &nbsp;&middot;&nbsp; <i class="fa-solid fa-signal"></i> Intermediate</div></div>
                <div class="lobj"><h3><i class="fa-solid fa-bullseye"></i>&nbsp; Learning Objectives</h3><ul><li>Understand the Principle of Least Privilege (PoLP)</li><li>Enforce password complexity standards and use password managers</li><li>Implement Defense in Depth layered architecture</li><li>Understand patch management and security updates</li></ul></div>
                <div class="ns"><h2><div class="si"><i class="fa-solid fa-user-shield"></i></div> Principle of Least Privilege</h2>
                <p>Always grant users and processes the minimum necessary permissions required to perform their specific tasks. This drastically reduces the attack surface and damage when accounts are compromised.</p>
                <div class="cb"><span class="cl">Access Rule</span><pre>user_role = <span class="st">"guest"</span>
<span class="kw">if</span> user_role == <span class="st">"admin"</span>:
    <span class="fn">grant_full_system_access</span>()
<span class="kw">else</span>:
    <span class="fn">restrict_to_read_only</span>()</pre></div></div>
                <div class="ns"><h2><div class="si"><i class="fa-solid fa-cubes"></i></div> Defense in Depth</h2>
                <p>Never rely on a single layer of security. Effective security requires multiple defensive measures spread across different layers (Physical, Perimeter, Network, Host, Application, Data).</p>
                <div class="tip"><strong><i class="fa-solid fa-lightbulb" style="color:var(--amber);"></i> Password Policy Rules:</strong><p>Enforce minimum length of 12+ characters, inclusion of numbers, uppercase and lowercase characters, symbols, and prohibit dictionary words.</p></div></div>
            </div>

            <!-- ── 2.0 Labs ── -->
            <div id="panel-labs" class="pp" style="display:none;">
                <div id="bn-labs"></div>
                <div class="lhdr"><h1>Interactive Sandbox &mdash; Security Labs</h1><div class="lmeta"><i class="fa-solid fa-clock"></i> 30 min &nbsp;&middot;&nbsp; <i class="fa-solid fa-flask"></i> 6 Exercises</div></div>

                <!-- Exercise wrapper -->
                <div id="labWrap" class="lab-wrap">
                    <div class="lab-prog-row">
                        <span class="lab-prog-lbl" id="labProgLbl">Exercise 1 of 6</span>
                    </div>
                    <div class="lab-prog-bar"><div class="lab-prog-fill" id="labProgFill" style="width:0%"></div></div>

                    <div class="lab-task-card">
                        <div class="lab-task-num" id="labTaskNum">Exercise 1</div>
                        <div class="lab-task-q" id="labTaskQ"></div>
                        <div class="lab-hint" id="labHint"></div>
                    </div>

                    <div class="lab-code-lbl"><i class="fa-solid fa-terminal" style="color:var(--primary);"></i> Your Command / Code</div>
                    <textarea class="lab-code-area" id="labCodeArea" spellcheck="false" autocomplete="off" autocorrect="off" autocapitalize="off" placeholder="# Type your answer here..."></textarea>

                    <!-- Status banner -->
                    <div class="lab-status" id="labStatus" style="display:none;"></div>

                    <!-- Model answer (shown after wrong attempt) -->
                    <div class="lab-answer" id="labAnswer" style="display:none;">
                        <div class="lab-ans-hdr"><i class="fa-solid fa-circle-check"></i> Correct Answer</div>
                        <pre class="lab-ans-code" id="labAnsCode"></pre>
                        <div class="lab-ans-exp" id="labAnsExp"></div>
                    </div>

                    <!-- Retype instruction -->
                    <div class="lab-retype-msg" id="labRetypeMsg" style="display:none;">
                        <i class="fa-solid fa-keyboard"></i> <span id="labRetypeTxt">Now type the correct answer above to continue.</span>
                    </div>

                    <div class="lab-nav" style="margin-top:16px;">
                        <button type="button" class="lab-check-btn" id="labCheckBtn" onclick="checkLabAnswer()"><i class="fa-solid fa-play"></i> Check My Answer</button>
                        <button type="button" class="lab-got" id="labNextBtn" style="display:none;" onclick="labNext()">Next Exercise <i class="fa-solid fa-arrow-right"></i></button>
                    </div>
                </div>

                <!-- Done screen -->
                <div id="labDone" style="display:none;">
                    <div class="lab-done-card">
                        <div class="lab-done-ico"><i class="fa-solid fa-shield-halved" style="font-size:50px;color:var(--primary);"></i></div>
                        <h2>Lab Complete!</h2>
                        <div class="lab-score-b" id="labDoneScore"></div>
                        <p id="labDoneMsg"></p>
                        <button type="button" class="lab-restart" onclick="initLab()"><i class="fa-solid fa-rotate-left"></i> Restart Lab</button>
                    </div>
                </div>
            </div>

            <!-- ── 2.1 Quiz ── -->
            <div id="panel-quiz" class="qp" style="display:none;">

                <!-- Attempt tracker -->
                <div class="q-attempt-bar" id="qAttemptBar">
                    <span class="qa-label" id="qaLabel">Attempt 1 of 3</span>
                    <div class="qa-dots" id="qaDots">
                        <div class="qa-dot" id="dot1">1</div>
                        <div class="qa-dot" id="dot2">2</div>
                        <div class="qa-dot" id="dot3">3</div>
                    </div>
                </div>

                <!-- Active quiz -->
                <div id="quizActive">
                    <div class="qbar-wrap"><div class="qbar-fill" id="qFill" style="width:0%"></div></div>
                    <div class="qbadge" id="qBadge">Question 1 of 8</div>
                    <div class="qtext" id="qText"></div>
                    <div class="qopts" id="qOpts"></div>
                    <div class="qwarn" id="qWarn"></div>
                    <div class="qnav">
                        <div style="display:flex;gap:10px;">
                            <button type="button" class="qbtn q-skip" onclick="skipQ()">Skip</button>
                            <button type="button" class="qbtn q-fin" id="qFinBtn" onclick="submitQuiz()" style="display:none;"><i class="fa-solid fa-paper-plane"></i> Submit Quiz</button>
                        </div>
                        <button type="button" class="qbtn q-next" id="qNextBtn" onclick="nextQ()">Next <i class="fa-solid fa-arrow-right"></i></button>
                    </div>
                    <div class="qtracker">
                        <div class="qti"><span class="qtl">Correct</span><span class="qtv" id="qtC">0</span></div>
                        <div class="qti"><span class="qtl">Skipped</span><span class="qtv" id="qtS">0</span></div>
                        <div class="qti"><span class="qtl">Remaining</span><span class="qtv" id="qtR">8</span></div>
                    </div>
                </div>

                <!-- Locked state (3 fails) -->
                <div id="quizLocked" style="display:none;">
                    <div class="q-locked-panel">
                        <div class="q-locked-ico"><i class="fa-solid fa-lock"></i></div>
                        <h2>Quiz Locked</h2>
                        <p>You have used all 3 attempts without passing. The correct answers and explanations are shown below.</p>
                        <div class="q-locked-score" id="qLockedScore"><i class="fa-solid fa-chart-bar"></i> Best Score: &mdash;</div>
                        <button type="button" class="q-review-btn" onclick="switchLesson(document.getElementById('li-intro'),'intro')"><i class="fa-solid fa-book-open"></i> Review Course Notes</button>
                    </div>
                    <div class="qr-bd" id="answerKeyBd" style="margin-top:20px;text-align:left;"></div>
                </div>

                <!-- Already passed state -->
                <div id="quizPassed" style="display:none;">
                    <div class="cert-ul-card">
                        <div class="cert-ul-header">
                            <div class="cert-ul-icon"><i class="fa-solid fa-circle-check"></i></div>
                            <h2>Quiz Passed!</h2>
                            <p>Your certificate is now unlocked</p>
                        </div>
                        <div class="cert-ul-body">
                            <div class="cert-score-b" id="qPassedScore"><i class="fa-solid fa-circle-check"></i> Assessment Passed</div>
                            <p>You have successfully passed this assessment. Head to the certificate page to download your official credential.</p>
                            <button type="button" class="cert-get" onclick="switchLesson(document.getElementById('li-cert'),'cert')"><i class="fa-solid fa-award"></i> View Certificate</button>
                            <br/><button type="button" class="q-review-btn" onclick="reviewLastAnswers()" style="margin-top:14px;"><i class="fa-solid fa-list-check"></i> Review My Answers &amp; Explanations</button>
                        </div>
                    </div>
                </div>

                <!-- Result after submission -->
                <div class="qresult" id="quizResult">
                    <div class="qr-ring" id="qrRing"><div class="qr-pct" id="qrPct">0%</div><div class="qr-plbl">Your Score</div></div>
                    <div class="qr-badge" id="qrBadge"></div>
                    <div class="qr-msg" id="qrMsg"></div>
                    <div class="qr-stats" style="margin-bottom:20px;">
                        <div class="qr-stat"><div class="qr-sv" id="qrC">0</div><div class="qr-sl">Correct</div></div>
                        <div class="qr-stat"><div class="qr-sv" id="qrW">0</div><div class="qr-sl">Wrong / Skipped</div></div>
                        <div class="qr-stat"><div class="qr-sv" id="qrA">1</div><div class="qr-sl">Attempt</div></div>
                    </div>
                    <div class="qr-bd" id="qrBd"><h4><i class="fa-solid fa-list-check"></i> Detailed Breakdown</h4></div>
                    <div class="qr-acts">
                        <button type="button" class="qr-btn qr-retry" id="retryBtn" onclick="retakeQuiz()"><i class="fa-solid fa-rotate-left"></i> Retake Quiz</button>
                        <button type="button" class="qr-btn qr-cert" id="qrCertBtn" onclick="switchLesson(document.getElementById('li-cert'),'cert')"><i class="fa-solid fa-award"></i> Get Certificate</button>
                    </div>
                </div>
            </div>

            <!-- ── 2.2 Discussion ── -->
            <div id="panel-disc" class="dp" style="display:none;">
                <div class="lhdr"><h1>Discussion Forum</h1><div class="lmeta"><i class="fa-solid fa-users"></i> <span id="discCnt">4</span> posts &nbsp;&middot;&nbsp; Cybersecurity Basics</div></div>
                <div class="dpost">
                    <div class="ph"><div class="pav" style="background:linear-gradient(135deg,#6366f1,#4f46e5);">AL</div><div class="pm"><div class="pa">Alex</div><div class="pt">2 hours ago</div></div></div>
                    <div class="pb"><p>Welcome to the Cybersecurity Basics discussion forum! Let's use this space to ask questions about threats and defense strategies.</p></div>
                    <div class="pacts"><button type="button" class="pab" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> <span>5</span></button></div>
                </div>
                <div class="dpost">
                    <div class="ph"><div class="pav" style="background:linear-gradient(135deg,#22c55e,#16a34a);">LN</div><div class="pm"><div class="pa">Lina</div><div class="pt">5 hours ago</div></div></div>
                    <div class="pb"><p>Does anyone have a good explanation of the difference between symmetric and asymmetric encryption?</p></div>
                    <div class="pacts"><button type="button" class="pab" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> <span>12</span></button></div>
                    <div class="preps"><div class="rrow"><div class="rav" style="background:linear-gradient(135deg,#0099ff,#007acc);">AD</div><div class="rbub"><div class="ra">admin &middot; 4 hours ago</div><p>Sure Lina! Symmetric encryption uses the same key for both encryption and decryption, whereas asymmetric encryption uses a public-private key pair.</p></div></div></div>
                </div>
                <div class="dpost">
                    <div class="ph"><div class="pav" style="background:linear-gradient(135deg,#f59e0b,#d97706);">SP</div><div class="pm"><div class="pa">Sam P.</div><div class="pt">Yesterday</div></div></div>
                    <div class="pb"><p>Remember: Multi-Factor Authentication (MFA) adds an extra verification layer. Even if someone steals your password, they can't access your account without your secondary device or biometrics!</p></div>
                    <div class="pacts"><button type="button" class="pab" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> <span>8</span></button></div>
                </div>
                <div class="dpost">
                    <div class="ph"><div class="pav" style="background:linear-gradient(135deg,#6366f1,#4f46e5);">DN</div><div class="pm"><div class="pa">Daniel</div><div class="pt">30 minutes ago</div></div></div>
                    <div class="pb"><p>Is it secure to store user passwords in a database using MD5 hashing?</p></div>
                    <div class="pacts"><button type="button" class="pab" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> <span>3</span></button></div>
                    <div class="preps"><div class="rrow"><div class="rav" style="background:linear-gradient(135deg,#0099ff,#007acc);">AD</div><div class="rbub"><div class="ra">admin <span style="background:#dbeafe;color:#1e40af;font-size:10px;padding:1px 6px;border-radius:10px;margin-left:4px;font-weight:700;">STAFF</span> &middot; 15 minutes ago</div><p>No, MD5 is cryptographically broken and highly vulnerable to collision attacks and brute-forcing. Always use secure, modern salted algorithms like bcrypt or PBKDF2.</p></div></div></div>
                </div>
                <div class="npbox">
                    <h3><i class="fa-solid fa-pen-to-square" style="color:var(--primary);"></i> Post a Reply</h3>
                    <textarea id="newPost" placeholder="Share a question, tip, or insight about Cybersecurity..."></textarea>
                    <div class="psr"><button type="button" class="psub" onclick="submitPost()"><i class="fa-solid fa-paper-plane"></i> Post</button></div>
                </div>
            </div>

            <!-- ── Feedback ── -->
            <div id="panel-feedback" class="pp" style="display:none;">
                <div class="lhdr"><h1>Course Feedback</h1><div class="lmeta"><i class="fa-solid fa-star"></i> Share your experience</div></div>
                <div class="pcard">
                    <div class="pico" style="background:rgba(245,158,11,.1);"><i class="fa-solid fa-comment-dots" style="color:var(--amber);"></i></div>
                    <p>Rate the course and share your experience. Your feedback helps improve the quality of learning for all students on NetGuard.</p>
                    <button type="button" class="plaunch" onclick="launchPage('feedback')" style="background:#d97706;"><i class="fa-solid fa-pen"></i> Give Feedback</button>
                </div>
            </div>

            <!-- ── Certificate LOCKED ── -->
            <div id="panel-cert-locked" class="pp" style="display:none;">
                <div class="lhdr"><h1>Course Certificate</h1><div class="lmeta"><i class="fa-solid fa-lock"></i> Complete requirements to unlock</div></div>
                <div class="cert-lk-card">
                    <div class="clk-ico"><i class="fa-solid fa-lock"></i></div>
                    <h2>Certificate Locked</h2>
                    <p>Complete all requirements below to earn your official NetGuard Cybersecurity Basics certificate.</p>
                    <ul class="req-list">
                        <li class="req-li">
                            <div class="req-ico pend" id="req-lessons-ico"><i class="fa-solid fa-check"></i></div>
                            <div><strong>Complete all course lessons</strong><br/><span id="req-lessons-txt" style="font-size:12px;color:var(--muted);">0 of 5 lessons marked complete</span></div>
                        </li>
                        <li class="req-li">
                            <div class="req-ico pend" id="req-quiz-ico"><i class="fa-solid fa-check"></i></div>
                            <div><strong>Pass the Self-Assessment Quiz (>= 80%)</strong><br/><span id="req-quiz-txt" style="font-size:12px;color:var(--muted);">Not attempted yet</span></div>
                        </li>
                    </ul>
                    <button type="button" class="cert-goto" onclick="switchLesson(document.getElementById('li-quiz'),'quiz')"><i class="fa-solid fa-clipboard-check"></i> Go to Quiz</button>
                </div>
            </div>

            <!-- ── Certificate UNLOCKED ── -->
            <div id="panel-cert-unlocked" class="pp" style="display:none;">
                <div class="cert-ul-card">
                    <div class="cert-ul-header">
                        <div class="cert-ul-icon"><i class="fa-solid fa-award"></i></div>
                        <h2>Certificate Earned</h2>
                        <p>Cybersecurity Basics &mdash; NetGuard</p>
                    </div>
                    <div class="cert-ul-body">
                        <div class="cert-score-b"><i class="fa-solid fa-circle-check"></i> All Requirements Completed</div>
                        <p>You have completed all course lessons and passed the assessment. Your official NetGuard Cybersecurity Basics certificate is ready.</p>
                        <button type="button" class="cert-get" onclick="launchPage('cert')"><i class="fa-solid fa-download"></i> Download Certificate</button>
                    </div>
                </div>
            </div>

        </div><!-- /scroll -->

        <div class="foot">
            <button type="button" class="fb fg" onclick="prevLesson()"><i class="fa-solid fa-arrow-left"></i> Previous</button>
            <button type="button" class="fb fp" onclick="nextLesson()">Next <i class="fa-solid fa-arrow-right"></i></button>
        </div>
    </div>

</form>

<script>
var courseID = '<%= Request.QueryString["CourseID"] ?? "" %>';
var username = '<%= Session["Username"] ?? "guest" %>';
var userType = '<%= Session["UserType"] ?? "Member" %>';

var LESSONS_ORDER = ['intro','auth','best','labs','quiz','disc','feedback','cert'];
var TRACKABLE     = ['intro','auth','best','labs','quiz','disc'];
var PAGES         = { labs:'VirtualLabs.aspx', feedback:'Feedback.aspx', cert:'Certificates.aspx' };
var TITLES        = { intro:'1.0: Foundations &amp; Threats', auth:'1.1: Authentication &amp; Encryption', best:'1.2: Security Best Practices', labs:'2.0: Interactive Sandbox &mdash; Security Labs', quiz:'2.1: Self-Assessment Quiz', disc:'2.2: Discussion Forum', feedback:'Course Feedback', cert:'Course Certificate' };

var state = { lessons:{}, quizPassed:false, quizAttempts:0, bestScore:null, lastScore:null, lastAnswers:[], discussions:[] };
var currentKey = 'intro';

/* ════════════════════
   INIT: load from server
═════════════════════ */
document.addEventListener('DOMContentLoaded', function() {
    // Populate topbar user chip + menu header
    var av = document.getElementById('tbUserAv');
    var un = document.getElementById('tbUserName');
    if (username && username !== 'guest') {
        var initials = username.substring(0, 2).toUpperCase();
        av.textContent = initials;
        un.textContent = username;
        var umAv = document.getElementById('umAv'); if (umAv) umAv.textContent = initials;
        var umNm = document.getElementById('umName'); if (umNm) umNm.textContent = username;
    }

    loadFromServer().then(function() {
        applyAllStatuses();
        updateProgress();
        updateCertSidebar();
        updateAttemptBar();
        loadDiscussion();
        var start = (localStorage.getItem('ng_last_'+username+'_'+courseID) || 'intro');
        if (!document.getElementById('li-'+start)) start = 'intro';
        switchLesson(document.getElementById('li-'+start), start, true);
    });
});

/* localStorage helpers — fallback when DB unavailable */
function _lsKey()   { return 'ng_state_'  + username + '_' + courseID; }
function _discKey() { return 'ng_disc_'   + courseID; }

function saveToLocal() {
    try { localStorage.setItem(_lsKey(), JSON.stringify({
        lessons:state.lessons, quizPassed:state.quizPassed,
        quizAttempts:state.quizAttempts, bestScore:state.bestScore,
        lastScore:state.lastScore, lastAnswers:state.lastAnswers
    })); } catch(e) {}
}
function loadFromLocal() {
    try {
        var s = JSON.parse(localStorage.getItem(_lsKey()));
        if (!s) return;
        state.lessons      = s.lessons      || {};
        state.quizPassed   = s.quizPassed   || false;
        state.quizAttempts = s.quizAttempts || 0;
        state.bestScore    = (s.bestScore    !== undefined && s.bestScore    !== null) ? s.bestScore    : null;
        state.lastScore    = (s.lastScore    !== undefined && s.lastScore    !== null) ? s.lastScore    : null;
        state.lastAnswers  = s.lastAnswers  || [];
    } catch(e) {}
}

async function loadFromServer() {
    try {
        var r = await fetch('ProgressHandler.ashx?action=load&courseID=' + encodeURIComponent(courseID));
        var d = await r.json();
        if (d.error) throw new Error(d.error);
        state.lessons      = d.lessons      || {};
        state.quizPassed   = d.quizPassed   || false;
        state.quizAttempts = d.quizAttempts || 0;
        state.bestScore    = d.bestScore    !== false ? d.bestScore    : null;
        state.lastScore    = d.lastScore    !== false ? d.lastScore    : null;
        state.lastAnswers  = d.lastAnswers  || [];
        state.discussions  = d.discussions  || [];
        saveToLocal(); // keep localStorage in sync with server
    } catch(e) {
        console.warn('Server load failed, falling back to localStorage', e);
        loadFromLocal();
    }
}

/* ════════════════════
   LESSON NAVIGATION
═════════════════════ */
function switchLesson(el, key, silent) {
    document.querySelectorAll('.li,.sa').forEach(function(i){ i.classList.remove('active'); });
    if (el) el.classList.add('active');
    currentKey = key;
    if (!silent) localStorage.setItem('ng_last_'+username+'_'+courseID, key);

    document.getElementById('tbTitle').innerHTML = TITLES[key] || key;
    document.getElementById('mainScroll').scrollTop = 0;

    // Auto-save visit
    if (TRACKABLE.indexOf(key) !== -1 && state.lessons[key] !== 'complete') {
        state.lessons[key] = 'visited';
        applyStatus(key);
        autoSaveLesson(key, 'visited');
    }
    updateMcButton();

    // Show correct panel
    var allP = ['intro','auth','best','labs','quiz','disc','feedback','cert-locked','cert-unlocked'];
    allP.forEach(function(p){ var x=document.getElementById('panel-'+p); if(x) x.style.display='none'; });

    if (key === 'cert') {
        document.getElementById(state.quizPassed ? 'panel-cert-unlocked' : 'panel-cert-locked').style.display = '';
        updateCertPanel();
    } else if (key === 'quiz') {
        document.getElementById('panel-quiz').style.display = '';
        initQuizView();
    } else {
        var p = document.getElementById('panel-'+key);
        if (p) p.style.display = '';
    }
}

function go(el, key)   { switchLesson(el, key); }
function prevLesson()  { var i=LESSONS_ORDER.indexOf(currentKey); if(i>0){ var k=LESSONS_ORDER[i-1]; switchLesson(document.getElementById('li-'+k), k); } }
function nextLesson()  { var i=LESSONS_ORDER.indexOf(currentKey); if(i<LESSONS_ORDER.length-1){ var k=LESSONS_ORDER[i+1]; switchLesson(document.getElementById('li-'+k), k); } }
function toggleMod(id) { document.getElementById(id).classList.toggle('col'); }
function launchPage(k) { if(PAGES[k]) window.location.href = PAGES[k]+(courseID?'?CourseID='+courseID:''); }
function certClick()   { switchLesson(document.getElementById('li-cert'),'cert'); }

/* ════════════════════
   MARK COMPLETE
═════════════════════ */
function markComplete(key) {
    state.lessons[key] = 'complete';
    applyStatus(key);
    updateProgress();
    renderBanner(key);
    updateCertSidebar();
    updateCertPanel();
    updateMcButton();
    saveToLocal();
    autoSaveLesson(key, 'complete');
}

function undoComplete(key) {
    state.lessons[key] = 'visited';
    applyStatus(key);
    updateProgress();
    renderBanner(key);
    updateCertSidebar();
    updateCertPanel();
    updateMcButton();
    saveToLocal();
    autoSaveLesson(key, 'visited');
}

function applyAllStatuses() { TRACKABLE.forEach(applyStatus); }

function applyStatus(key) {
    var st = state.lessons[key] || 'unvisited';
    var el = document.getElementById('st-'+key);
    if (el) { el.className='ls'; if(st==='visited') el.classList.add('visited'); if(st==='complete') el.classList.add('complete'); }
    renderBanner(key);
}

function renderBanner(key) {
    var el = document.getElementById('bn-'+key);
    if (!el) return;
    el.innerHTML = (state.lessons[key]==='complete')
        ? '<div class="cbanner"><div class="cb-l"><div class="cb-ico"><i class="fa-solid fa-check"></i></div><div class="cb-t"><strong>Lesson Complete</strong><span>You\'ve finished this lesson.</span></div></div><button type="button" class="cb-undo" onclick="undoComplete(\''+key+'\')">Undo</button></div>'
        : '';
}

/* ════════════════════
   PROGRESS + CERT UI
═════════════════════ */
function updateProgress() {
    var done = TRACKABLE.filter(function(k){ return state.lessons[k]==='complete'; }).length;
    var pct  = Math.round(done/TRACKABLE.length*100);
    document.getElementById('opPct').textContent  = pct+'%';
    document.getElementById('opFill').style.width = pct+'%';
    var tc = document.getElementById('tbComp');
    tc.textContent = done+' of '+TRACKABLE.length+' completed';
    tc.className   = 'tb-comp'+(done===TRACKABLE.length?' done':'');

    var m1 = ['intro','auth','best']; document.getElementById('m1c').textContent = m1.filter(function(k){ return state.lessons[k]==='complete'; }).length+' / '+m1.length;
    var m2 = ['labs','quiz','disc'];  document.getElementById('m2c').textContent = m2.filter(function(k){ return state.lessons[k]==='complete'; }).length+' / '+m2.length;

    // Cert requirements
    var nonQuiz = TRACKABLE.filter(function(k){ return k!=='quiz'; });
    var nqDone  = nonQuiz.filter(function(k){ return state.lessons[k]==='complete'; }).length;
    var ri = document.getElementById('req-lessons-ico'), rt = document.getElementById('req-lessons-txt');
    if (ri && rt) {
        if (nqDone===nonQuiz.length) { ri.className='req-ico done'; rt.innerHTML='All '+nonQuiz.length+' lessons complete &#10003;'; rt.style.color='#166534'; }
        else { ri.className='req-ico pend'; rt.textContent=nqDone+' of '+nonQuiz.length+' lessons complete'; rt.style.color=''; }
    }
}

function updateCertSidebar() {
    var el=document.getElementById('li-cert'), ico=document.getElementById('certSbIco'), nb=document.getElementById('certSbNew');
    if (state.quizPassed) { el.className='sa cert-sa unlocked'; ico.className='fa-solid fa-award'; nb.style.display=''; }
    else { el.className='sa cert-sa cert-locked'; ico.className='fa-solid fa-lock'; nb.style.display='none'; }
}

function updateCertPanel() {
    var qi=document.getElementById('req-quiz-ico'), qt=document.getElementById('req-quiz-txt');
    if (!qi) return;
    if (state.quizPassed) { qi.className='req-ico done'; qt.innerHTML='Passed with '+state.bestScore+'% &#10003;'; qt.style.color='#166534'; }
    else if (state.lastScore!==null) { qi.className='req-ico pend'; qt.textContent='Last score: '+state.lastScore+'% - need 80% to pass'; qt.style.color='#ef4444'; }
    else { qi.className='req-ico pend'; qt.textContent='Not attempted yet'; qt.style.color=''; }
    var sv=document.getElementById('certScoreVal'); if(sv) sv.innerHTML=(state.bestScore!==null?state.bestScore+'%':'&mdash;');
}

/* ════════════════════
   AUTO-SAVE (DB)
═════════════════════ */
var saveTimer = null;
function autoSaveLesson(key, status) {
    showToast('Saving…', false);
    fetch('ProgressHandler.ashx?action=saveLesson', {
        method:'POST', headers:{'Content-Type':'application/json'},
        body: JSON.stringify({ courseID: courseID, lessonKey: key, status: status })
    }).then(function(){ showToast('Saved', true); }).catch(function(){ hideToast(); });
}

function showToast(msg, success) {
    clearTimeout(saveTimer);
    var ind = document.getElementById('tbSaveInd');
    if (!ind) return;
    ind.className = 'tb-save-ind ' + (success ? 'saved' : 'saving');
    ind.innerHTML = success
        ? '<i class="fa-solid fa-circle-check"></i> Saved'
        : '<i class="fa-solid fa-spinner fa-spin"></i> Saving…';
    if (success) saveTimer = setTimeout(function(){ ind.className='tb-save-ind'; ind.innerHTML=''; }, 2500);
}
function hideToast() {
    var ind = document.getElementById('tbSaveInd');
    if (ind) { ind.className='tb-save-ind'; ind.innerHTML=''; }
}

/* ════════════════════
   TOPBAR MC BUTTON
═════════════════════ */
var NO_AUTO_COMPLETE = ['quiz','labs','feedback','cert'];
function updateMcButton() {}
function markCurrentComplete() {}

/* Auto-complete on scroll to bottom */
document.addEventListener('DOMContentLoaded', function() {
    var scrollArea = document.getElementById('mainScroll');
    if (scrollArea) {
        scrollArea.addEventListener('scroll', function() {
            var el = this;
            var atBottom = el.scrollTop + el.clientHeight >= el.scrollHeight - 30;
            if (atBottom && NO_AUTO_COMPLETE.indexOf(currentKey) === -1
                         && TRACKABLE.indexOf(currentKey) !== -1
                         && state.lessons[currentKey] !== 'complete') {
                markComplete(currentKey);
            }
        });
    }
});

/* ════════════════════
   QUIZ ENGINE
═════════════════════ */
var questions = [
    { q:'What is the primary purpose of a firewall?',
      opts:['To prevent physical theft of servers','To monitor and control incoming and outgoing network traffic','To speed up the internet connection','To encrypt passwords'], ans:1,
      exp:'A firewall monitors and controls network traffic based on predetermined security rules, acting as a barrier between trusted and untrusted networks.' },
    { q:'Which of the following is an example of a Social Engineering attack?',
      opts:['SQL Injection','Phishing','DDoS','Cross-Site Scripting (XSS)'], ans:1,
      exp:'Phishing relies on human deception to steal sensitive information, making it a classic social engineering attack.' },
    { q:'What does \'HTTPS\' stand for?',
      opts:['HyperText Transfer Protocol Secure','HyperText Transmission Protocol System','Hyperlink Transfer Technology Protocol','HyperText Transfer Protocol Standard'], ans:0,
      exp:'HTTPS stands for HyperText Transfer Protocol Secure. It encrypts communication between the browser and the web server.' },
    { q:'Which type of malware is designed to demand payment in exchange for restoring access to data?',
      opts:['Spyware','Adware','Ransomware','Trojan'], ans:2,
      exp:'Ransomware encrypts a victim\'s files and demands a ransom payment (usually in cryptocurrency) to unlock them.' },
    { q:'What is a \'Zero-Day\' vulnerability?',
      opts:['A vulnerability that has been fixed','A software bug known to the vendor but without a patch yet','A computer with zero viruses','A network with no firewalls'], ans:1,
      exp:'A Zero-Day vulnerability is an unpatched software flaw that is unknown to the vendor, leaving zero days to fix it before it might be exploited.' },
    { q:'What are the three core pillars of the CIA Triad in cybersecurity?',
      opts:['Control, Integrity, Access','Confidentiality, Identity, Authentication','Confidentiality, Integrity, Availability','Computer, Internet, Application'], ans:2,
      exp:'The CIA Triad stands for Confidentiality, Integrity, and Availability. These are the core goals of any information security program.' },
    { q:'Which of the following statements is true regarding symmetric encryption?',
      opts:['It uses two different keys for encryption and decryption','It is slower than asymmetric encryption','It uses the same single key for both encryption and decryption','It is primarily used for secure key exchanges'], ans:2,
      exp:'Symmetric encryption uses a single, shared secret key to both encrypt and decrypt data, making it faster and more suitable for bulk data.' },
    { q:'What is the Principle of Least Privilege?',
      opts:['Giving users access to all network resources by default','Limiting user access to only the minimum resources needed to perform their job','Using the shortest possible passwords for convenience','Restricting internet access to zero websites'], ans:1,
      exp:'The Principle of Least Privilege dictates that users and systems should only have the minimum access rights required to perform their specific functions, minimizing damage from compromised accounts.' }
];

var qIdx=0, qCorrect=0, qSkipped=0, qAnswers=[];

function initQuizView() {
    var locked  = state.quizAttempts >= 3 && !state.quizPassed;
    var passed  = state.quizPassed;
    var hasHist = state.quizAttempts > 0;

    document.getElementById('quizActive').style.display  = 'none';
    document.getElementById('quizLocked').style.display  = 'none';
    document.getElementById('quizPassed').style.display  = 'none';
    document.getElementById('quizResult').style.display  = 'none';

    updateAttemptBar();

    if (passed) {
        document.getElementById('quizPassed').style.display = '';
        document.getElementById('qPassedScore').innerHTML   = '<i class="fa-solid fa-star"></i> Best Score: ' + (state.bestScore!==null?state.bestScore+'%':'&mdash;');
    } else if (locked) {
        document.getElementById('quizLocked').style.display = '';
        document.getElementById('qLockedScore').innerHTML   = '<i class="fa-solid fa-chart-bar"></i> Best Score: ' + (state.bestScore!==null?state.bestScore+'%':'&mdash;');
        showAnswerKey();
    } else if (hasHist && state.lastAnswers && state.lastAnswers.length > 0) {
        // Show previous result on first view of quiz panel
        renderResultFromHistory();
    } else {
        // Fresh start
        startQuiz();
    }
}

function startQuiz() {
    qIdx=0; qCorrect=0; qSkipped=0; qAnswers=[];
    document.getElementById('quizResult').style.display = 'none';
    document.getElementById('quizActive').style.display = '';
    renderQ();
}

function updateAttemptBar() {
    var total=3, used=Math.min(state.quizAttempts, 3);
    var nextAttempt = state.quizPassed ? '&mdash;' : (used<3 ? 'Attempt '+(used+1)+' of 3' : 'All 3 attempts used');
    document.getElementById('qaLabel').innerHTML = state.quizPassed ? 'Quiz Passed &#10003;' : nextAttempt;
    for (var i=1; i<=3; i++) {
        var dot = document.getElementById('dot'+i);
        dot.className = 'qa-dot';
        if (i <= used) {
            dot.classList.add((state.quizPassed && i===used) ? 'used-pass' : 'used-fail');
        } else if (!state.quizPassed && i===used+1 && used<3) {
            dot.classList.add('current');
        }
    }
}

function renderQ() {
    var q=questions[qIdx], total=questions.length;
    document.getElementById('qBadge').textContent  = 'Question '+(qIdx+1)+' of '+total;
    document.getElementById('qText').textContent   = q.q;
    document.getElementById('qWarn').textContent   = '';
    document.getElementById('qFill').style.width   = (qIdx/total*100)+'%';
    document.getElementById('qtC').textContent     = qCorrect;
    document.getElementById('qtS').textContent     = qSkipped;
    document.getElementById('qtR').textContent     = total-qIdx;
    var last = qIdx===total-1;
    document.getElementById('qNextBtn').style.display = last?'none':'';
    document.getElementById('qFinBtn').style.display  = last?'flex':'none';
    var opts=document.getElementById('qOpts'); opts.innerHTML='';
    q.opts.forEach(function(opt,i){
        var d=document.createElement('div'); d.className='qopt';
        d.innerHTML='<input type="radio" name="qR" value="'+i+'" id="r'+i+'"><label for="r'+i+'">'+opt+'</label><i class="oc fa-solid fa-check"></i>';
        d.addEventListener('click',function(){
            document.querySelectorAll('.qopt').forEach(function(x){ x.classList.remove('sel'); });
            d.classList.add('sel'); d.querySelector('input').checked=true;
        });
        opts.appendChild(d);
    });
}

function getSel() { var r=document.querySelector('input[name="qR"]:checked'); return r?parseInt(r.value):-1; }

function nextQ() {
    var sel=getSel();
    if(sel===-1){ document.getElementById('qWarn').textContent='Please select an answer or click Skip.'; return; }
    qAnswers.push({qIdx:qIdx,sel:sel,correct:sel===questions[qIdx].ans,skipped:false});
    if(sel===questions[qIdx].ans) qCorrect++;
    qIdx++; if(qIdx<questions.length) renderQ(); else showResult();
}

function skipQ() {
    qAnswers.push({qIdx:qIdx,sel:-1,correct:false,skipped:true});
    qSkipped++; qIdx++; if(qIdx<questions.length) renderQ(); else showResult();
}

function submitQuiz() {
    var sel=getSel();
    if(sel===-1){ document.getElementById('qWarn').textContent='Please select an answer or click Skip.'; return; }
    qAnswers.push({qIdx:qIdx,sel:sel,correct:sel===questions[qIdx].ans,skipped:false});
    if(sel===questions[qIdx].ans) qCorrect++;
    showResult();
}

function showResult() {
    document.getElementById('quizActive').style.display='none';
    document.getElementById('qFill').style.width='100%';
    var pct=Math.round(qCorrect/questions.length*100), passed=pct>=80;

    // Update state immediately — do not wait for server response
    state.quizAttempts++;
    state.lastScore = pct;
    if (passed) {
        state.quizPassed=true; state.bestScore=pct;
        state.lessons['quiz']='complete'; applyStatus('quiz');
    } else if (state.bestScore===null||pct>state.bestScore) state.bestScore=pct;
    state.lastAnswers = qAnswers.map(function(a){ return {qIdx:a.qIdx,sel:a.sel,correct:a.correct,skipped:a.skipped}; });
    saveToLocal(); // persist to localStorage immediately
    updateProgress(); updateCertSidebar(); updateCertPanel(); updateAttemptBar();

    if (passed) {
        setTimeout(function(){
            switchLesson(document.getElementById('li-cert'), 'cert');
        }, 2500);
    }

    // Then attempt server save (secondary persistence)
    showToast('Saving…', false);
    fetch('ProgressHandler.ashx?action=saveQuiz', {
        method:'POST', headers:{'Content-Type':'application/json'},
        body: JSON.stringify({ courseID:courseID, score:pct, passed:passed, answers:qAnswers })
    }).then(function(r){ return r.json(); }).then(function(d){
        if (d.ok || d.error==='already_passed') showToast('Saved', true);
        else hideToast();
    }).catch(function(){ hideToast(); });

    renderResultUI(qAnswers, pct, passed, state.quizAttempts);
}

function showAnswerKey() {
    var bd = document.getElementById('answerKeyBd');
    if (!bd) return;
    bd.innerHTML = '<h4><i class="fa-solid fa-key"></i> Full Answer Key &amp; Explanations</h4>';
    questions.forEach(function(q, i) {
        bd.innerHTML +=
            '<div class="qr-qi">' +
              '<div class="qr-qi-top">' +
                '<div class="qr-ico c"><i class="fa-solid fa-check"></i></div>' +
                '<div class="qr-qtxt">Q' + (i+1) + ': ' + q.q + '</div>' +
              '</div>' +
              '<div class="qr-ans correct"><i class="fa-solid fa-check"></i> Correct Answer: <strong>' + q.opts[q.ans] + '</strong></div>' +
              '<div class="qr-exp"><strong><i class="fa-solid fa-lightbulb" style="color:var(--amber);"></i> Explanation:</strong> ' + q.exp + '</div>' +
            '</div>';
    });
}

function renderResultFromHistory() {
    var answers=state.lastAnswers;
    var correct=answers.filter(function(a){ return a.correct; }).length;
    var pct = state.lastScore !== null ? state.lastScore : Math.round(correct/questions.length*100);
    var passed = pct >= 80;
    renderResultUI(answers, pct, passed, state.quizAttempts);
}

function reviewLastAnswers() {
    document.getElementById('quizPassed').style.display='none';
    document.getElementById('quizResult').style.display='none';
    renderResultFromHistory();
}

function renderResultUI(answers, pct, passed, attemptNum) {
    var res=document.getElementById('quizResult');
    res.style.display='block';

    var ring=document.getElementById('qrRing'), pctEl=document.getElementById('qrPct');
    ring.className='qr-ring '+(passed?'pass':'fail');
    pctEl.className='qr-pct '+(passed?'pass':'fail');
    pctEl.textContent=pct+'%';

    var badge=document.getElementById('qrBadge');
    badge.className='qr-badge '+(passed?'pass':'fail');
    badge.innerHTML=(passed?'<i class="fa-solid fa-circle-check"></i> PASSED':'<i class="fa-solid fa-circle-xmark"></i> NOT PASSED');

    var msgs={
        pass: 'Excellent! You scored '+pct+'% and passed the Cybersecurity assessment. Your certificate is now unlocked.',
        mid:  'You scored '+pct+'%. You need 80% to pass. Review the lessons below and try again.',
        low:  'You scored '+pct+'%. Study the course material carefully &mdash; focus on the areas where you made mistakes.'
    };
    document.getElementById('qrMsg').innerHTML = passed?msgs.pass:(pct>=50?msgs.mid:msgs.low);

    var correct = answers.filter(function(a){ return a.correct; }).length;
    document.getElementById('qrC').textContent = correct;
    document.getElementById('qrW').textContent = questions.length - correct;
    document.getElementById('qrA').textContent = attemptNum||state.quizAttempts||1;

    // Breakdown with explanations
    var bd=document.getElementById('qrBd');
    bd.innerHTML='<h4><i class="fa-solid fa-list-check"></i> Detailed Breakdown &amp; Explanations</h4>';
    answers.forEach(function(a){
        var q=questions[a.qIdx];
        var cls=a.skipped?'s':(a.correct?'c':'w');
        var ico=a.skipped?'<i class="fa-solid fa-minus"></i>':(a.correct?'<i class="fa-solid fa-check"></i>':'<i class="fa-solid fa-xmark"></i>');
        var ansHtml='';
        if (a.skipped) {
            ansHtml='<div class="qr-ans skipped"><i class="fa-solid fa-forward-step"></i> Skipped &nbsp;&middot;&nbsp; Correct answer: <strong>'+q.opts[q.ans]+'</strong></div>';
        } else if (a.correct) {
            ansHtml='<div class="qr-ans correct"><i class="fa-solid fa-check"></i> Correct: <strong>'+q.opts[a.sel]+'</strong></div>';
        } else {
            ansHtml='<div class="qr-ans wrong"><i class="fa-solid fa-xmark"></i> Your answer: <strong>'+q.opts[a.sel]+'</strong> &nbsp;&middot;&nbsp; Correct: <strong>'+q.opts[q.ans]+'</strong></div>';
        }
        var expHtml = '<div class="qr-exp"><strong><i class="fa-solid fa-lightbulb" style="color:var(--amber);"></i> Explanation:</strong> '+q.exp+'</div>';
        bd.innerHTML+='<div class="qr-qi qr-qi-'+cls+'"><div class="qr-qi-top"><div class="qr-ico '+cls+'">'+ico+'</div><div class="qr-qtxt">'+q.q+'</div></div>'+ansHtml+expHtml+'</div>';
    });

    // Show/hide retry & cert buttons
    var locked = state.quizAttempts >= 3 && !state.quizPassed;
    var retryBtn=document.getElementById('retryBtn');
    retryBtn.style.display = (locked||passed) ? 'none' : '';
    document.querySelectorAll('.qr-locked-msg').forEach(function(el){ el.remove(); });
    if (locked && !passed) {
        var lockMsg=document.createElement('div'); lockMsg.className='qr-locked-msg';
        lockMsg.innerHTML='<h3><i class="fa-solid fa-lock"></i> No Attempts Remaining</h3><p>You have used all 3 attempts. Please review the course materials and contact your instructor.</p>';
        document.getElementById('qrBd').after(lockMsg);
    }
    document.getElementById('qrCertBtn').style.display = passed?'':'none';
}

function retakeQuiz() {
    if (state.quizAttempts >= 3) return;
    document.getElementById('quizResult').style.display='none';
    startQuiz();
}

/* ════════════════════
   DISCUSSION
═════════════════════ */
function toggleLike(btn) {
    btn.classList.toggle('liked');
    var sp=btn.querySelector('span'), n=parseInt(sp.textContent), ic=btn.querySelector('i');
    sp.textContent=btn.classList.contains('liked')?n+1:n-1;
    ic.className=btn.classList.contains('liked')?'fa-solid fa-thumbs-up':'fa-regular fa-thumbs-up';
}

function _appendDiscPost(postedUser, txt, time, postedUserType, isHtml) {
    var uName = postedUser || username || 'Guest';
    var initials = uName.substring(0,2).toUpperCase();
    var isOPAdmin = (postedUserType === 'Admin' || uName.toLowerCase() === 'admin');
    var avatarBg = isOPAdmin ? 'linear-gradient(135deg,#0099ff,#007acc)' : 'linear-gradient(135deg,#6366f1,#4f46e5)';
    if (uName.toLowerCase() === 'lina') avatarBg = 'linear-gradient(135deg,#22c55e,#16a34a)';
    if (uName.toLowerCase() === 'sam p.') avatarBg = 'linear-gradient(135deg,#f59e0b,#d97706)';
    if (uName.toLowerCase() === 'jamie r.') avatarBg = 'linear-gradient(135deg,#6366f1,#4f46e5)';
    if (uName.toLowerCase() === 'maya k.') avatarBg = 'linear-gradient(135deg,#22c55e,#16a34a)';
    if (uName.toLowerCase() === 'chris l.') avatarBg = 'linear-gradient(135deg,#f59e0b,#d97706)';

    var p=document.createElement('div'); p.className='dpost';
    p.innerHTML=
        '<div class="ph">' +
            '<div class="pav" style="background:'+avatarBg+';">'+initials+'</div>' +
            '<div class="pm">' +
                '<div class="pa">'+uName+(isOPAdmin ? ' <span style="background:#dbeafe;color:#1e40af;font-size:10px;padding:1px 6px;border-radius:10px;margin-left:4px;font-weight:700;">STAFF</span>' : '')+'</div>' +
                '<div class="pt">'+(time||'Just now')+'</div>' +
            '</div>' +
        '</div>' +
        '<div class="pb"><p>'+(isHtml ? txt : txt.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'))+'</p></div>' +
        '<div class="pacts"><button type="button" class="pab" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> <span>0</span></button></div>';
    document.querySelector('.npbox').parentNode.insertBefore(p, document.querySelector('.npbox'));
    document.getElementById('discCnt').textContent=document.querySelectorAll('#panel-disc .dpost').length;
}

function loadDiscussion() {
    var dbPosts = state.discussions || [];
    var lsPosts = [];
    try {
        lsPosts = JSON.parse(localStorage.getItem(_discKey()) || '[]');
    } catch(e) {}
    
    var userPosts = dbPosts.length > 0 ? dbPosts : lsPosts;
    var formattedUserPosts = [];
    userPosts.forEach(function(p) {
        var msgText = p.msg || p.txt || '';
        var msgUser = p.username || username || 'Member';
        var msgTime = p.date || p.time || 'Just now';
        var msgType = p.userType || 'Member';
        
        var isDefault = ['alex', 'lina', 'admin', 'sam p.', 'daniel'].indexOf(msgUser.toLowerCase()) !== -1 
                        && (msgText.indexOf('Welcome to the') !== -1 
                            || msgText.indexOf('symmetric and asymmetric') !== -1 
                            || msgText.indexOf('Symmetric encryption') !== -1 
                            || msgText.indexOf('Multi-Factor') !== -1 
                            || msgText.indexOf('MD5') !== -1 
                            || msgText.indexOf('MD5 is cryptographically') !== -1);
                            
        if (!isDefault) {
            formattedUserPosts.push({ username: msgUser, msg: msgText, date: msgTime, userType: msgType });
        }
    });

    document.querySelectorAll('#panel-disc .dpost').forEach(function(el){ el.remove(); });

    // Render Default Cybersecurity Comments
    _appendDiscPost('Alex', 'Welcome to the Cybersecurity Basics discussion forum! Let\'s use this space to ask questions about threats and defense strategies.', '2 hours ago', 'Member', true);

    _appendDiscPost('Lina', 'Does anyone have a good explanation of the difference between symmetric and asymmetric encryption?', '5 hours ago', 'Member', true);
    var posts = document.querySelectorAll('#panel-disc .dpost');
    var lastPost = posts[posts.length - 1];
    if (lastPost) {
        var reps = document.createElement('div');
        reps.className = 'preps';
        reps.innerHTML = '<div class="rrow"><div class="rav" style="background:linear-gradient(135deg,#0099ff,#007acc);">AD</div><div class="rbub"><div class="ra">admin <span style="background:#dbeafe;color:#1e40af;font-size:10px;padding:1px 6px;border-radius:10px;margin-left:4px;font-weight:700;">STAFF</span> &middot; 4 hours ago</div><p>Sure Lina! Symmetric encryption uses the same key for both encryption and decryption, whereas asymmetric encryption uses a public-private key pair.</p></div></div>';
        lastPost.appendChild(reps);
    }

    _appendDiscPost('Sam P.', 'Remember: Multi-Factor Authentication (MFA) adds an extra verification layer. Even if someone steals your password, they can\'t access your account without your secondary device or biometrics!', 'Yesterday', 'Member', true);

    _appendDiscPost('Daniel', 'Is it secure to store user passwords in a database using MD5 hashing?', '30 minutes ago', 'Member', true);
    var posts2 = document.querySelectorAll('#panel-disc .dpost');
    var lastPost2 = posts2[posts2.length - 1];
    if (lastPost2) {
        var reps = document.createElement('div');
        reps.className = 'preps';
        reps.innerHTML = '<div class="rrow"><div class="rav" style="background:linear-gradient(135deg,#0099ff,#007acc);">AD</div><div class="rbub"><div class="ra">admin <span style="background:#dbeafe;color:#1e40af;font-size:10px;padding:1px 6px;border-radius:10px;margin-left:4px;font-weight:700;">STAFF</span> &middot; 15 minutes ago</div><p>No, MD5 is cryptographically broken and highly vulnerable to collision attacks and brute-forcing. Always use secure, modern salted algorithms like bcrypt or PBKDF2.</p></div></div>';
        lastPost2.appendChild(reps);
    }

    // Render User Posts
    formattedUserPosts.forEach(function(entry){
        _appendDiscPost(entry.username, entry.msg, entry.date, entry.userType, false);
    });

    document.getElementById('discCnt').textContent = document.querySelectorAll('#panel-disc .dpost').length;
}

function submitPost() {
    var ta=document.getElementById('newPost'), txt=ta.value.trim();
    if(!txt) return;
    var time=new Date().toLocaleString();
    _appendDiscPost(username, txt, 'Just now', (typeof userType !== 'undefined' ? userType : 'Member'));
    
    // Save to database
    fetch('ProgressHandler.ashx?action=saveDiscussion', {
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body: JSON.stringify({ courseID: courseID, message: txt })
    }).then(function(r){ return r.json(); }).then(function(d){
        if (d.ok) {
            state.discussions.push({ username: username, msg: txt, date: time, userType: (typeof userType !== 'undefined' ? userType : 'Member') });
        }
    }).catch(function(err){ console.error('Failed to save comment to DB', err); });

    // Save to localStorage as a fallback
    try {
        var posts=JSON.parse(localStorage.getItem(_discKey())||'[]');
        posts.push({username:username, txt:txt,time:time,userType: (typeof userType !== 'undefined' ? userType : 'Member')});
        localStorage.setItem(_discKey(), JSON.stringify(posts));
    } catch(e){}
    ta.value='';
}

/* ════════════════════
   VIRTUAL LAB ENGINE
═════════════════════ */
var labExercises = [
    {
        q: 'Identify the suspicious/phishing domain in this list: secure-netguard.com, netguard.com, netguard-secure-login.net, portal.netguard.com. Enter the phishing domain name.',
        hint: 'Hint: Phishing domains often use typosquatting or add extra words (e.g. netguard-secure-login.net). Subdomains like portal.netguard.com are secure.',
        answer: 'netguard-secure-login.net',
        exp: 'Phishing domains mimic legitimate companies by adding hyphenated words or altering spelling to deceive targets.'
    },
    {
        q: 'Write a firewall rule command to block all inbound traffic from IP 198.51.100.45. Use format: DROP inbound from 198.51.100.45',
        hint: 'Hint: Enter the command exactly as: DROP inbound from 198.51.100.45',
        answer: 'DROP inbound from 198.51.100.45',
        exp: 'Firewall rules define block/allow behaviors. Restricting specific malicious IPs cuts off network access from attackers.'
    },
    {
        q: 'Implement a simple symmetric encryption. Write a Python function encrypt(char, key) that returns the character XORed with the key. Hint: use chr(ord(char) ^ key)',
        hint: 'Hint: def encrypt(char, key):\n    return chr(ord(char) ^ key)',
        answer: 'def encrypt(char, key):\n    return chr(ord(char) ^ key)',
        exp: 'XOR symmetric encryption is easily reversible: applying key XOR to the ciphertext returns the plaintext.'
    },
    {
        q: 'An attacker modifies a database record to change their account balance. Which pillar of the CIA Triad has been violated? (Confidentiality, Integrity, or Availability)',
        hint: 'Hint: Enter either Confidentiality, Integrity, or Availability.',
        answer: 'Integrity',
        exp: 'Integrity guarantees data remains accurate, complete, and free from unauthorized modifications.'
    },
    {
        q: 'Write a Python condition that checks if a password is valid: length at least 8, and contains a digit. Write the function is_secure(pwd) using any(c.isdigit() for c in pwd) and len(pwd) >= 8 returning True or False.',
        hint: 'Hint: def is_secure(pwd):\n    return len(pwd) >= 8 and any(c.isdigit() for c in pwd)',
        answer: 'def is_secure(pwd):\n    return len(pwd) >= 8 and any(c.isdigit() for c in pwd)',
        exp: 'Checking length and character classes enforces password complexity policy checks during setup.'
    },
    {
        q: 'Write a statement to check if the file hash file_hash matches expected_hash. Print "Secure" if they match, else "Tampered".',
        hint: 'Hint: Use if/else conditions. Indent each print statement with 4 spaces.',
        answer: 'if file_hash == expected_hash:\n    print("Secure")\nelse:\n    print("Tampered")',
        exp: 'Hash verification compares file integrity. Changing a single character alters the output signature completely.'
    }
];

var labIdx = 0, labGotCount = 0, labPhase = 'input';

function labNorm(code) {
    return code.split('\n')
               .map(function(l){ return l.replace(/\s+$/, ''); })
               .join('\n').trim();
}

function initLab() {
    labIdx = 0; labGotCount = 0;
    document.getElementById('labDone').style.display = 'none';
    document.getElementById('labWrap').style.display = '';
    renderLabEx();
}

function renderLabEx() {
    labPhase = 'input';
    var ex = labExercises[labIdx];
    var pct = Math.round(labIdx / labExercises.length * 100);
    document.getElementById('labProgFill').style.width = pct + '%';
    document.getElementById('labProgLbl').textContent = 'Exercise ' + (labIdx+1) + ' of ' + labExercises.length;
    document.getElementById('labTaskNum').textContent = 'Exercise ' + (labIdx+1);
    document.getElementById('labTaskQ').textContent = ex.q;
    document.getElementById('labHint').textContent = ex.hint;
    document.getElementById('labAnsCode').textContent = ex.answer;
    document.getElementById('labAnsExp').innerHTML = ex.exp;

    var area = document.getElementById('labCodeArea');
    area.value = '';
    area.disabled = false;
    area.placeholder = '# Type your answer here...';
    area.focus();

    document.getElementById('labStatus').style.display = 'none';
    document.getElementById('labAnswer').style.display = 'none';
    document.getElementById('labRetypeMsg').style.display = 'none';
    document.getElementById('labCheckBtn').style.display = '';
    document.getElementById('labNextBtn').style.display = 'none';
}

function checkLabAnswer() {
    var area = document.getElementById('labCodeArea');
    if (!area.value.trim()) {
        area.style.borderColor = 'var(--red)';
        setTimeout(function(){ area.style.borderColor = ''; }, 1200);
        return;
    }
    var correct = labNorm(area.value) === labNorm(labExercises[labIdx].answer);
    if (correct) {
        labGotCount++;
        labPhase = 'correct';
        var st = document.getElementById('labStatus');
        st.style.display = '';
        st.className = 'lab-status correct';
        st.innerHTML = '<i class="fa-solid fa-circle-check"></i> Correct! Great work.';
        area.disabled = true;
        document.getElementById('labCheckBtn').style.display = 'none';
        document.getElementById('labNextBtn').style.display = '';
    } else {
        labPhase = 'wrong';
        var st2 = document.getElementById('labStatus');
        st2.style.display = '';
        st2.className = 'lab-status wrong';
        st2.innerHTML = '<i class="fa-solid fa-circle-xmark"></i> Not quite right. Study the correct answer below, then retype it above to continue.';
        document.getElementById('labAnswer').style.display = '';
        document.getElementById('labRetypeMsg').style.display = '';
        document.getElementById('labRetypeTxt').textContent = 'Now type the correct answer above to continue.';
        area.value = '';
        area.placeholder = 'Retype the correct answer here...';
        area.focus();
        document.getElementById('labCheckBtn').style.display = 'none';
        document.getElementById('labNextBtn').style.display = 'none';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    var area = document.getElementById('labCodeArea');
    if (area) {
        area.addEventListener('input', function() {
            if (labPhase !== 'wrong') return;
            if (labNorm(this.value) === labNorm(labExercises[labIdx].answer)) {
                document.getElementById('labNextBtn').style.display = '';
                document.getElementById('labRetypeTxt').innerHTML = '<strong style="color:var(--green-d);">&#10003; Correct — click Next to continue.</strong>';
            } else {
                document.getElementById('labNextBtn').style.display = 'none';
                document.getElementById('labRetypeTxt').textContent = 'Now type the correct answer above to continue.';
            }
        });
    }
    initLab();
});

function labNext() {
    labIdx++;
    if (labIdx >= labExercises.length) showLabDone();
    else renderLabEx();
}

/* ════════════════════
   USER MENU / RESET
═════════════════════ */
function toggleUserMenu() {
    var m = document.getElementById('userMenu');
    var ch = document.getElementById('umChevron');
    var open = m.style.display === 'block';
    m.style.display = open ? 'none' : 'block';
    if (ch) ch.style.transform = open ? '' : 'rotate(180deg)';
    if (!open) hideResetConfirm();
}
function closeUserMenu() {
    var m = document.getElementById('userMenu'), ch = document.getElementById('umChevron');
    if (m) m.style.display = 'none';
    if (ch) ch.style.transform = '';
    hideResetConfirm();
}
function showResetConfirm() {
    document.getElementById('umResetDefault').style.display = 'none';
    document.getElementById('umResetConfirm').style.display = '';
}
function hideResetConfirm() {
    var d = document.getElementById('umResetDefault'), c = document.getElementById('umResetConfirm');
    if (d) d.style.display = ''; if (c) c.style.display = 'none';
}
function doReset() {
    var btn = document.querySelector('#umResetConfirm .um-confirm');
    if (btn) { btn.disabled = true; btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Resetting...'; }

    // 1. Reset in-memory state immediately
    state.lessons = {}; state.quizPassed = false; state.quizAttempts = 0;
    state.bestScore = null; state.lastScore = null; state.lastAnswers = [];

    // 2. Clear + overwrite localStorage with the now-empty state
    [_lsKey(), 'ng_last_'+username+'_'+courseID, _discKey()].forEach(function(k){ localStorage.removeItem(k); });
    saveToLocal();

    // 3. Mark session so loadFromServer skips restoring old server data on reload
    try { sessionStorage.setItem('ng_reset_'+courseID, '1'); } catch(e) {}

    // 4. Refresh all UI with blank state
    applyAllStatuses(); updateProgress(); updateCertSidebar(); updateAttemptBar();
    closeUserMenu();
    switchLesson(document.getElementById('li-intro'), 'intro');

    // 5. Best-effort server delete
    fetch('ProgressHandler.ashx?action=resetProgress', {
        method:'POST', headers:{'Content-Type':'application/json'},
        body: JSON.stringify({ courseID: courseID })
    });
}
document.addEventListener('click', function(e) {
    var wrap = document.getElementById('userMenuWrap');
    if (wrap && !wrap.contains(e.target)) closeUserMenu();
});

function showLabDone() {
    document.getElementById('labWrap').style.display = 'none';
    document.getElementById('labDone').style.display = '';
    markComplete('labs');
    var total = labExercises.length;
    document.getElementById('labDoneScore').innerHTML = '<i class="fa-solid fa-star"></i> ' + labGotCount + ' of ' + total + ' correct first try';
    document.getElementById('labDoneMsg').textContent = labGotCount === total
        ? 'Perfect score! You got every exercise right first try.'
        : labGotCount >= Math.ceil(total / 2)
            ? 'Good effort! Some exercises needed a second try — that\'s how learning works.'
            : 'Keep at it — revisit the lessons and retry the lab.';
}
</script>
</body>
</html>
