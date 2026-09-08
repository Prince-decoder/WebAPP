<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Ashutosh Job Portal</title>
    <meta name="description" content="Sign in to Ashutosh Job Portal — your gateway to career opportunities.">
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --black:      #050000;
            --deep:       #0d0000;
            --void:       #130000;
            --dark-red:   #1c0000;
            --mid-red:    #3d0000;
            --blood:      #7a0000;
            --crimson:    #a80000;
            --glow:       #cc1a00;
            --bright:     #e63000;
            --ember:      #ff4500;
            --muted:      #7a4040;
            --text-dim:   #a06060;
            --text-main:  #d4a0a0;
            --text-light: #f0d0d0;
        }

        html, body {
            min-height: 100vh;
            background: var(--black);
            color: var(--text-main);
            font-family: 'Inter', sans-serif;
            overflow: hidden;
        }

        .bg-scene { position: fixed; inset: 0; z-index: 0; }

        .bg-gradient {
            position: absolute; inset: 0;
            background:
                radial-gradient(ellipse 60% 80% at 80% 50%, rgba(180,0,0,0.35) 0%, transparent 65%),
                radial-gradient(ellipse 40% 60% at 20% 30%, rgba(80,0,0,0.4) 0%, transparent 60%),
                linear-gradient(135deg, #050000 0%, #0d0000 40%, #1c0000 70%, #050000 100%);
        }

        .moon {
            position: absolute; top: 50%; right: 30%;
            transform: translate(50%, -50%);
            width: 340px; height: 340px; border-radius: 50%;
            background: radial-gradient(circle, rgba(255,240,220,0.08) 0%, rgba(200,100,60,0.04) 40%, transparent 70%);
            box-shadow: 0 0 80px 40px rgba(200,50,0,0.08), 0 0 200px 100px rgba(160,0,0,0.05);
            animation: moonPulse 6s ease-in-out infinite;
        }
        @keyframes moonPulse {
            0%,100%{opacity:.6;transform:translate(50%,-50%) scale(1)}
            50%{opacity:1;transform:translate(50%,-50%) scale(1.04)}
        }

        .embers { position: absolute; inset: 0; overflow: hidden; pointer-events: none; }
        .ember {
            position: absolute; bottom: -10px;
            border-radius: 50%; background: var(--ember);
            box-shadow: 0 0 6px 2px rgba(255,69,0,0.8);
            animation: floatEmber linear infinite; opacity: 0;
        }
        @keyframes floatEmber {
            0%{opacity:0;transform:translateY(0) translateX(0) scale(1)}
            10%{opacity:1}
            80%{opacity:.6}
            100%{opacity:0;transform:translateY(-110vh) translateX(var(--drift)) scale(0.3)}
        }

        .scanlines {
            position: absolute; inset: 0; pointer-events: none;
            background: repeating-linear-gradient(0deg, transparent, transparent 2px, rgba(0,0,0,0.06) 2px, rgba(0,0,0,0.06) 4px);
        }

        .splatter { position: absolute; border-radius: 50%; filter: blur(60px); opacity: .12; pointer-events: none; }
        .splatter-1 { width:300px;height:200px;background:#cc1a00;top:10%;left:-5%;animation:drift1 12s ease-in-out infinite; }
        .splatter-2 { width:200px;height:300px;background:#7a0000;bottom:15%;right:5%;animation:drift2 15s ease-in-out infinite; }
        @keyframes drift1{0%,100%{transform:translate(0,0)}50%{transform:translate(30px,20px)}}
        @keyframes drift2{0%,100%{transform:translate(0,0)}50%{transform:translate(-20px,-30px)}}

        .page-wrapper {
            position: relative; z-index: 10; min-height: 100vh;
            display: flex; align-items: center; justify-content: center; padding: 2rem;
        }

        .login-card {
            width: 100%; max-width: 420px;
            background: rgba(13,0,0,0.75);
            border: 1px solid rgba(122,0,0,0.5);
            border-radius: 20px; padding: 2.8rem 2.4rem;
            backdrop-filter: blur(24px) saturate(160%);
            -webkit-backdrop-filter: blur(24px) saturate(160%);
            box-shadow: 0 0 0 1px rgba(204,26,0,0.1), 0 8px 40px rgba(0,0,0,0.8),
                        0 0 80px rgba(122,0,0,0.15), inset 0 1px 0 rgba(255,255,255,0.04);
            animation: cardReveal 0.8s cubic-bezier(0.22,1,0.36,1) both;
        }
        @keyframes cardReveal {
            from{opacity:0;transform:translateY(30px) scale(0.96)}
            to{opacity:1;transform:translateY(0) scale(1)}
        }

        .brand { text-align: center; margin-bottom: 2rem; }
        .brand-sigil {
            display: inline-flex; align-items: center; justify-content: center;
            width: 60px; height: 60px; border-radius: 50%;
            background: radial-gradient(circle at 30% 30%, #3d0000, #050000);
            border: 1.5px solid rgba(204,26,0,0.6);
            box-shadow: 0 0 24px rgba(204,26,0,0.35), inset 0 0 12px rgba(204,26,0,0.15);
            margin: 0 auto 1rem;
            animation: sigilGlow 3s ease-in-out infinite;
        }
        @keyframes sigilGlow {
            0%,100%{box-shadow:0 0 24px rgba(204,26,0,.35),inset 0 0 12px rgba(204,26,0,.15)}
            50%{box-shadow:0 0 40px rgba(204,26,0,.6),inset 0 0 20px rgba(204,26,0,.3)}
        }
        .brand-sigil svg { width: 28px; height: 28px; }

        .brand-title {
            font-family: 'Cinzel', serif; font-size: 1.5rem; font-weight: 700;
            letter-spacing: .12em; text-transform: uppercase;
            background: linear-gradient(135deg,#f0d0d0 0%,#cc1a00 50%,#f0d0d0 100%);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
        }
        .brand-subtitle {
            margin-top: .3rem; font-size: .75rem; font-weight: 300;
            letter-spacing: .25em; text-transform: uppercase; color: var(--muted);
        }

        .divider { display:flex;align-items:center;gap:.75rem;margin:1.6rem 0; }
        .divider::before,.divider::after {
            content:''; flex:1; height:1px;
            background: linear-gradient(to right, transparent, rgba(122,0,0,0.6));
        }
        .divider::after { background: linear-gradient(to left, transparent, rgba(122,0,0,0.6)); }
        .divider span { font-size:.7rem;font-weight:500;letter-spacing:.2em;text-transform:uppercase;color:var(--muted);white-space:nowrap; }

        .form-group { margin-bottom: 1.2rem; }
        .form-label {
            display:block; font-size:.72rem; font-weight:600; letter-spacing:.18em;
            text-transform:uppercase; color:var(--text-dim); margin-bottom:.5rem; transition:color .2s;
        }
        .form-group:focus-within .form-label { color: var(--glow); }
        .form-group:focus-within .input-icon { color: var(--glow); }

        .input-wrapper { position: relative; }
        .input-icon {
            position:absolute; left:14px; top:50%; transform:translateY(-50%);
            color:var(--blood); transition:color .3s; pointer-events:none; display:flex;
        }
        .form-input {
            width:100%; padding:.78rem 1rem .78rem 2.75rem;
            background:rgba(5,0,0,0.6); border:1px solid rgba(61,0,0,0.8);
            border-radius:10px; color:var(--text-light);
            font-family:'Inter',sans-serif; font-size:.9rem; font-weight:400;
            outline:none; transition:border-color .3s,box-shadow .3s,background .3s;
            caret-color:var(--glow);
        }
        .form-input::placeholder { color:rgba(122,64,64,0.55); font-weight:300; }
        .form-input:focus {
            border-color:rgba(204,26,0,0.7); background:rgba(19,0,0,0.7);
            box-shadow:0 0 0 3px rgba(204,26,0,0.12),0 0 20px rgba(204,26,0,0.08);
        }

        .toggle-pwd {
            position:absolute; right:12px; top:50%; transform:translateY(-50%);
            background:none; border:none; color:var(--muted); cursor:pointer;
            padding:4px; display:flex; align-items:center; transition:color .2s;
        }
        .toggle-pwd:hover { color: var(--text-main); }

        .form-options {
            display:flex; align-items:center; justify-content:space-between;
            margin-bottom:1.6rem; margin-top:-.2rem;
        }
        .checkbox-label {
            display:flex; align-items:center; gap:.5rem; cursor:pointer;
            font-size:.78rem; color:var(--text-dim); user-select:none;
        }
        .checkbox-label input[type="checkbox"] {
            appearance:none; width:15px; height:15px;
            border:1px solid rgba(122,0,0,0.7); border-radius:4px;
            background:rgba(5,0,0,0.6); cursor:pointer; position:relative;
            transition:border-color .2s,background .2s;
        }
        .checkbox-label input[type="checkbox"]:checked { background:var(--blood); border-color:var(--crimson); }
        .checkbox-label input[type="checkbox"]:checked::after {
            content:''; position:absolute; top:2px; left:4px;
            width:5px; height:8px; border:2px solid #fff;
            border-top:none; border-left:none; transform:rotate(45deg);
        }

        .forgot-link { font-size:.78rem; color:var(--text-dim); text-decoration:none; transition:color .2s; }
        .forgot-link:hover { color:var(--glow); text-decoration:underline; }

        .btn-login {
            width:100%; padding:.88rem; border:none; border-radius:10px;
            background:linear-gradient(135deg,#a80000 0%,#cc1a00 50%,#e63000 100%);
            color:#fff; font-family:'Cinzel',serif; font-size:.88rem; font-weight:600;
            letter-spacing:.2em; text-transform:uppercase; cursor:pointer;
            position:relative; overflow:hidden; transition:transform .2s,box-shadow .3s;
            box-shadow:0 4px 24px rgba(168,0,0,0.5),0 0 0 1px rgba(204,26,0,0.3);
        }
        .btn-login::before {
            content:''; position:absolute; inset:0;
            background:linear-gradient(135deg,transparent 0%,rgba(255,255,255,0.08) 50%,transparent 100%);
            transform:translateX(-100%); transition:transform .5s ease;
        }
        .btn-login:hover::before { transform:translateX(100%); }
        .btn-login:hover { transform:translateY(-1px); box-shadow:0 8px 32px rgba(204,26,0,0.65),0 0 0 1px rgba(230,48,0,0.4); }
        .btn-login:active { transform:translateY(0); }

        .btn-login .ripple {
            position:absolute; border-radius:50%; background:rgba(255,255,255,0.25);
            transform:scale(0); animation:rippleAnim .6s linear; pointer-events:none;
        }
        @keyframes rippleAnim{to{transform:scale(4);opacity:0}}

        .btn-login.loading .btn-text { opacity:0; }
        .btn-login.loading::after {
            content:''; position:absolute; width:18px; height:18px;
            border:2px solid rgba(255,255,255,0.3); border-top-color:#fff;
            border-radius:50%; animation:spin .7s linear infinite;
            top:50%;left:50%;transform:translate(-50%,-50%);
        }
        @keyframes spin{to{transform:translate(-50%,-50%) rotate(360deg)}}

        .btn-google {
            width:100%; padding:.78rem; border:1px solid rgba(122,0,0,0.5);
            border-radius:10px; background:rgba(13,0,0,0.6); color:var(--text-main);
            font-family:'Inter',sans-serif; font-size:.88rem; font-weight:500;
            letter-spacing:.04em; cursor:pointer;
            display:flex; align-items:center; justify-content:center; gap:.75rem;
            text-decoration:none; transition:background .25s,border-color .25s,box-shadow .25s,transform .2s;
            position:relative; overflow:hidden;
        }
        .btn-google::before {
            content:''; position:absolute; inset:0;
            background:linear-gradient(135deg,rgba(122,0,0,0.15) 0%,transparent 100%);
            opacity:0; transition:opacity .3s;
        }
        .btn-google:hover::before { opacity:1; }
        .btn-google:hover {
            border-color:rgba(204,26,0,0.6); background:rgba(28,0,0,0.7);
            box-shadow:0 4px 20px rgba(122,0,0,0.25); transform:translateY(-1px); color:var(--text-light);
        }
        .btn-google:active { transform:translateY(0); }
        .google-icon { width:20px; height:20px; flex-shrink:0; }

        .error-msg {
            display:none; align-items:center; gap:.5rem;
            background:rgba(122,0,0,0.2); border:1px solid rgba(168,0,0,0.5);
            border-radius:8px; padding:.6rem .9rem; font-size:.8rem; color:#ff8080;
            margin-bottom:1rem;
        }
        .error-msg.visible { display:flex; }

        .card-footer { text-align:center; margin-top:1.6rem; font-size:.78rem; color:var(--muted); }
        .card-footer a { color:var(--glow); text-decoration:none; font-weight:500; transition:color .2s,text-shadow .2s; }
        .card-footer a:hover { color:var(--ember); text-shadow:0 0 10px rgba(255,69,0,0.5); }
    </style>
</head>
<body>

<div class="bg-scene">
    <div class="bg-gradient"></div>
    <div class="moon"></div>
    <div class="splatter splatter-1"></div>
    <div class="splatter splatter-2"></div>
    <div class="embers" id="embers"></div>
    <div class="scanlines"></div>
</div>

<div class="page-wrapper">
    <div class="login-card">

        <div class="brand">
            <div class="brand-sigil">
                <svg viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M14 3C14 3 9 8 9 13C9 15.76 10.67 18.1 13 19.32V17C13 17 11 15.5 11 13C11 10.5 13 7.5 14 6C15 7.5 17 10.5 17 13C17 15.5 15 17 15 17V19.32C17.33 18.1 19 15.76 19 13C19 8 14 3 14 3Z" fill="url(#flamePrimary)"/>
                    <circle cx="14" cy="13" r="2" fill="rgba(255,100,60,0.8)"/>
                    <defs>
                        <linearGradient id="flamePrimary" x1="14" y1="3" x2="14" y2="24" gradientUnits="userSpaceOnUse">
                            <stop offset="0%" stop-color="#ff6030"/>
                            <stop offset="100%" stop-color="#7a0000"/>
                        </linearGradient>
                    </defs>
                </svg>
            </div>
            <h1 class="brand-title">Job Portal</h1>
            <p class="brand-subtitle">Sign in to continue</p>
        </div>

        <div class="error-msg" id="errorMsg">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <span id="errorText">Invalid credentials. Please try again.</span>
        </div>

        <form id="loginForm" method="post" action="/login" novalidate>

            <div class="form-group">
                <label class="form-label" for="username">Username</label>
                <div class="input-wrapper">
                    <span class="input-icon">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                            <circle cx="12" cy="7" r="4"/>
                        </svg>
                    </span>
                    <input type="text" id="username" name="username" class="form-input"
                           placeholder="Enter your username" autocomplete="username" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <div class="input-wrapper">
                    <span class="input-icon">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                        </svg>
                    </span>
                    <input type="password" id="password" name="password" class="form-input"
                           placeholder="Enter your password" autocomplete="current-password" required>
                    <button type="button" class="toggle-pwd" id="togglePwd" aria-label="Toggle password visibility">
                        <svg id="eyeIcon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                            <circle cx="12" cy="12" r="3"/>
                        </svg>
                    </button>
                </div>
            </div>

            <div class="form-options">
                <label class="checkbox-label">
                    <input type="checkbox" id="rememberMe" name="rememberMe">
                    Remember me
                </label>
                <a href="/forgot-password" class="forgot-link">Forgot password?</a>
            </div>

            <button type="submit" class="btn-login" id="loginBtn">
                <span class="btn-text">Enter the Portal</span>
            </button>
        </form>

        <div class="divider"><span>or continue with</span></div>

        <a href="http://localhost:8080/goLogin" class="btn-google" id="googleLoginBtn">
            <svg class="google-icon" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
                <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
                <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
                <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
                <path fill="none" d="M0 0h48v48H0z"/>
            </svg>
            Sign in with Google
        </a>

        <div class="card-footer">
            Don't have an account? <a href="/register">Create one</a>
        </div>

    </div>
</div>

<script>
    (function spawnEmbers() {
        const container = document.getElementById('embers');
        for (let i = 0; i < 22; i++) {
            const e = document.createElement('div');
            e.className = 'ember';
            const size  = Math.random() * 3 + 1.5;
            const left  = Math.random() * 100;
            const dur   = Math.random() * 12 + 8;
            const delay = Math.random() * 10;
            const drift = (Math.random() - 0.5) * 120;
            e.style.cssText = `left:${left}%;width:${size}px;height:${size}px;animation-duration:${dur}s;animation-delay:${delay}s;--drift:${drift}px;opacity:0;`;
            container.appendChild(e);
        }
    })();

    const togglePwd = document.getElementById('togglePwd');
    const pwdInput  = document.getElementById('password');
    const eyeIcon   = document.getElementById('eyeIcon');
    const eyeOpen   = '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>';
    const eyeClosed = '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/><path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/><line x1="1" y1="1" x2="23" y2="23"/>';

    togglePwd.addEventListener('click', () => {
        const isText = pwdInput.type === 'text';
        pwdInput.type = isText ? 'password' : 'text';
        eyeIcon.innerHTML = isText ? eyeOpen : eyeClosed;
    });

    document.getElementById('loginBtn').addEventListener('click', function(e) {
        const btn = this;
        const rect = btn.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        const ripple = document.createElement('span');
        ripple.className = 'ripple';
        ripple.style.cssText = `left:${x}px;top:${y}px;width:10px;height:10px;margin-left:-5px;margin-top:-5px;`;
        btn.appendChild(ripple);
        setTimeout(() => ripple.remove(), 700);
    });

    document.getElementById('loginForm').addEventListener('submit', function(e) {
        const user = document.getElementById('username').value.trim();
        const pass = document.getElementById('password').value.trim();
        const errEl = document.getElementById('errorMsg');
        if (!user || !pass) {
            e.preventDefault();
            document.getElementById('errorText').textContent = 'Please fill in all fields.';
            errEl.classList.add('visible');
            return;
        }
        errEl.classList.remove('visible');
        const btn = document.getElementById('loginBtn');
        btn.classList.add('loading');
        btn.disabled = true;
    });
</script>

</body>
</html>
