<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI Job Search · Ashutosh Portal</title>
    <meta name="description" content="Use AI to discover top companies recruiting for your desired role.">
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

        html, body { min-height: 100vh; background: var(--black); color: var(--text-main); font-family: 'Inter', sans-serif; }

        /* ── NAVBAR ── */
        nav {
            position: sticky; top: 0; z-index: 100;
            background: rgba(5,0,0,0.92);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(163,0,0,0.25);
            padding: 0 2rem;
        }
        .nav-inner {
            max-width: 1100px; margin: 0 auto;
            display: flex; align-items: center; justify-content: space-between;
            height: 64px;
        }
        .nav-brand {
            font-family: 'Cinzel', serif;
            font-size: 1.2rem; font-weight: 700;
            color: var(--text-light);
            text-decoration: none;
            display: flex; align-items: center; gap: 10px;
            letter-spacing: 0.08em;
        }
        .nav-brand .brand-icon {
            width: 28px; height: 28px;
            background: radial-gradient(circle at 40% 40%, var(--ember), var(--blood));
            border-radius: 50%;
            box-shadow: 0 0 12px rgba(204,26,0,0.6);
            flex-shrink: 0;
        }
        .nav-links { display: flex; gap: 2rem; list-style: none; }
        .nav-links a {
            color: var(--text-dim);
            text-decoration: none;
            font-size: 0.875rem; font-weight: 500;
            letter-spacing: 0.05em;
            transition: color 0.2s;
        }
        .nav-links a:hover { color: var(--text-light); }
        .nav-links a.active { color: var(--text-light); border-bottom: 1px solid var(--crimson); padding-bottom: 2px; }

        /* ── PAGE HEADER ── */
        .page-header {
            position: relative; overflow: hidden;
            padding: 5rem 2rem 4rem;
            text-align: center;
        }
        .page-header::before {
            content: '';
            position: absolute; inset: 0;
            background:
                radial-gradient(ellipse 60% 50% at 50% 110%, rgba(140,0,0,0.4) 0%, transparent 65%),
                linear-gradient(to bottom, var(--black) 0%, var(--deep) 100%);
            pointer-events: none;
        }
        .ai-badge {
            display: inline-flex; align-items: center; gap: 8px;
            font-family: 'Cinzel', serif;
            font-size: 0.65rem; letter-spacing: 0.3em;
            color: var(--crimson);
            text-transform: uppercase;
            margin-bottom: 1.5rem;
            padding: 0.35rem 1rem;
            border: 1px solid rgba(168,0,0,0.4);
            border-radius: 2px;
            background: rgba(30,0,0,0.5);
        }
        .ai-badge .pulse {
            width: 6px; height: 6px;
            background: var(--ember);
            border-radius: 50%;
            box-shadow: 0 0 8px var(--ember);
            animation: pulse 1.8s ease-in-out infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50%       { opacity: 0.4; transform: scale(0.7); }
        }

        .page-title {
            position: relative; z-index: 1;
            font-family: 'Cinzel', serif;
            font-size: clamp(1.8rem, 4vw, 2.8rem);
            font-weight: 700;
            color: var(--text-light);
            letter-spacing: 0.02em;
            margin-bottom: 1rem;
        }
        .page-title span { color: var(--ember); }
        .page-sub {
            position: relative; z-index: 1;
            font-size: 0.95rem; font-weight: 300;
            color: var(--text-dim);
            max-width: 480px; margin: 0 auto;
            line-height: 1.7;
        }

        /* ── SEARCH PANEL ── */
        .search-panel {
            position: relative; z-index: 2;
            max-width: 640px; margin: 2.5rem auto 0;
            padding: 0 2rem;
        }
        .search-box {
            display: flex; align-items: stretch;
            background: rgba(10,0,0,0.8);
            border: 1px solid rgba(160,0,0,0.5);
            border-radius: 4px;
            overflow: hidden;
            box-shadow: 0 0 30px rgba(120,0,0,0.2);
            transition: border-color 0.25s, box-shadow 0.25s;
        }
        .search-box:focus-within {
            border-color: var(--crimson);
            box-shadow: 0 0 40px rgba(200,26,0,0.3);
        }
        .search-prefix {
            display: flex; align-items: center;
            padding: 0 1rem;
            border-right: 1px solid rgba(120,0,0,0.3);
            color: var(--muted);
            font-size: 1rem;
            flex-shrink: 0;
        }
        #jobTypeInput {
            flex: 1;
            background: transparent; border: none; outline: none;
            color: var(--text-light);
            font-family: 'Inter', sans-serif;
            font-size: 1rem; font-weight: 300;
            padding: 1.1rem 1.2rem;
        }
        #jobTypeInput::placeholder { color: var(--muted); }
        #searchBtn {
            display: flex; align-items: center; gap: 10px;
            background: var(--blood);
            color: var(--text-light);
            border: none;
            font-family: 'Cinzel', serif;
            font-size: 0.75rem; font-weight: 600;
            letter-spacing: 0.15em;
            text-transform: uppercase;
            padding: 1.1rem 2rem;
            cursor: pointer;
            transition: background 0.25s, box-shadow 0.25s;
            white-space: nowrap;
            flex-shrink: 0;
        }
        #searchBtn:hover {
            background: var(--crimson);
            box-shadow: 0 0 20px rgba(200,26,0,0.5);
        }
        #searchBtn:disabled { opacity: 0.5; cursor: not-allowed; }
        .btn-arrow { transition: transform 0.2s; }
        #searchBtn:not(:disabled):hover .btn-arrow { transform: translateX(4px); }

        /* ── RESULTS AREA ── */
        .results-area {
            max-width: 900px; margin: 3.5rem auto; padding: 0 2rem 5rem;
        }

        /* ── LOADER ── */
        .loader {
            display: none;
            flex-direction: column; align-items: center; gap: 1.5rem;
            padding: 4rem 0; text-align: center;
        }
        .loader.visible { display: flex; }
        .loader-rings {
            position: relative; width: 56px; height: 56px;
        }
        .loader-rings::before, .loader-rings::after {
            content: '';
            position: absolute; inset: 0;
            border-radius: 50%;
            border: 2px solid transparent;
        }
        .loader-rings::before {
            border-top-color: var(--crimson);
            animation: spin 1s linear infinite;
        }
        .loader-rings::after {
            border-bottom-color: var(--blood);
            animation: spin 1.6s linear infinite reverse;
            inset: 8px;
        }
        @keyframes spin { to { transform: rotate(360deg); } }
        .loader-text {
            font-family: 'Cinzel', serif;
            font-size: 0.8rem; letter-spacing: 0.2em;
            color: var(--text-dim);
            animation: blink 1.5s ease-in-out infinite;
        }
        @keyframes blink { 0%,100%{opacity:1} 50%{opacity:0.4} }

        /* ── ERROR STATE ── */
        .error-box {
            display: none;
            padding: 2rem;
            border: 1px solid rgba(200,0,0,0.35);
            border-radius: 4px;
            background: rgba(30,0,0,0.5);
            text-align: center;
        }
        .error-box.visible { display: block; }
        .error-icon { font-size: 2rem; margin-bottom: 1rem; }
        .error-title { font-family: 'Cinzel', serif; color: var(--text-light); font-size: 1rem; margin-bottom: 0.5rem; }
        .error-msg { color: var(--text-dim); font-size: 0.875rem; }

        /* ── RESULTS HEADER ── */
        .results-header {
            display: none;
            align-items: center; justify-content: space-between;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(80,0,0,0.4);
        }
        .results-header.visible { display: flex; }
        .results-title {
            font-family: 'Cinzel', serif;
            font-size: 0.85rem; letter-spacing: 0.12em;
            color: var(--text-dim); text-transform: uppercase;
        }
        .results-count {
            background: rgba(120,0,0,0.3);
            border: 1px solid rgba(160,0,0,0.4);
            border-radius: 2px;
            padding: 0.2rem 0.65rem;
            font-size: 0.78rem; color: var(--text-main);
            font-family: 'Cinzel', serif;
        }

        /* ── JOBS GRID ── */
        .jobs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
            gap: 1.25rem;
        }

        /* ── JOB CARD ── */
        .job-card {
            position: relative; overflow: hidden;
            background: var(--void);
            border: 1px solid rgba(100,0,0,0.35);
            border-radius: 4px;
            padding: 1.75rem;
            transition: border-color 0.3s, transform 0.3s, box-shadow 0.3s;
            animation: fadeInUp 0.4s ease both;
        }
        @keyframes fadeInUp {
            from { opacity:0; transform: translateY(18px); }
            to   { opacity:1; transform: translateY(0); }
        }
        .job-card::before {
            content: '';
            position: absolute; top:0; left:0;
            width: 36px; height: 36px;
            border-top: 1px solid rgba(168,0,0,0.6);
            border-left: 1px solid rgba(168,0,0,0.6);
            pointer-events: none;
        }
        .job-card:hover {
            border-color: rgba(200,40,0,0.6);
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(120,0,0,0.2);
        }
        .job-header { display: flex; align-items: flex-start; gap: 1rem; margin-bottom: 1rem; }
        .company-avatar {
            width: 42px; height: 42px; flex-shrink: 0;
            border-radius: 50%;
            background: radial-gradient(circle at 35% 35%, var(--mid-red), var(--dark-red));
            border: 1px solid rgba(140,0,0,0.5);
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem;
            box-shadow: 0 0 14px rgba(120,0,0,0.3);
        }
        .job-meta { flex: 1; min-width: 0; }
        .job-title {
            font-family: 'Cinzel', serif;
            font-size: 0.95rem; font-weight: 600;
            color: var(--text-light);
            line-height: 1.4; margin-bottom: 0.35rem;
        }
        .experience-badge {
            display: inline-flex; align-items: center; gap: 5px;
            font-size: 0.72rem; letter-spacing: 0.05em;
            color: var(--text-dim);
            background: rgba(60,0,0,0.4);
            border: 1px solid rgba(100,0,0,0.35);
            border-radius: 2px;
            padding: 0.15rem 0.5rem;
        }
        .job-desc {
            font-size: 0.85rem; font-weight: 300;
            color: var(--text-dim); line-height: 1.65;
            margin-bottom: 1.25rem;
        }
        .tech-label {
            font-size: 0.68rem; letter-spacing: 0.12em;
            color: var(--muted); text-transform: uppercase;
            margin-bottom: 0.5rem;
            font-family: 'Cinzel', serif;
        }
        .tech-chips { display: flex; flex-wrap: wrap; gap: 0.4rem; }
        .chip {
            font-size: 0.75rem;
            color: var(--text-main);
            background: rgba(40,0,0,0.6);
            border: 1px solid rgba(100,0,0,0.4);
            border-radius: 2px;
            padding: 0.2rem 0.6rem;
            transition: border-color 0.2s, color 0.2s;
        }
        .chip:hover { border-color: var(--crimson); color: var(--text-light); }

        /* ── EMPTY STATE ── */
        .empty-state {
            display: none;
            flex-direction: column; align-items: center; gap: 1rem;
            padding: 5rem 2rem; text-align: center; color: var(--text-dim);
        }
        .empty-state.visible { display: flex; }
        .empty-icon { font-size: 2.5rem; opacity: 0.5; }
        .empty-title { font-family: 'Cinzel', serif; font-size: 1rem; color: var(--text-main); }

        /* ── FOOTER ── */
        footer {
            text-align: center; padding: 2rem;
            border-top: 1px solid rgba(80,0,0,0.3);
            color: var(--muted); font-size: 0.78rem; letter-spacing: 0.05em;
        }

        @media (max-width: 600px) {
            .nav-links { display: none; }
            .jobs-grid { grid-template-columns: 1fr; }
            #searchBtn { padding: 1.1rem 1.2rem; }
            .btn-label { display: none; }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <div class="nav-inner">
        <a class="nav-brand" href="/home">
            <div class="brand-icon"></div>
            Ashutosh Portal
        </a>
        <ul class="nav-links">
            <li><a href="/home">Home</a></li>
            <li><a href="/viewalljobs">All Jobs</a></li>
            <li><a href="/findjob" class="active">AI Search</a></li>
            <li><a href="/contact">Contact</a></li>
        </ul>
    </div>
</nav>

<!-- Page Header -->
<header class="page-header">
    <div style="position:relative;z-index:1;display:flex;flex-direction:column;align-items:center;">
        <div class="ai-badge">
            <span class="pulse"></span>
            Powered by Gemini AI
        </div>
        <h1 class="page-title">Find Your <span>Dream Role</span></h1>
        <p class="page-sub">Describe the position you're looking for and let AI surface the top companies currently hiring.</p>
    </div>
</header>

<!-- Search Panel -->
<div class="search-panel">
    <div class="search-box">
        <div class="search-prefix">🔍</div>
        <input
            type="text"
            id="jobTypeInput"
            placeholder="e.g. fresh Java developer, senior data scientist..."
            autocomplete="off"
            aria-label="Job type search"
        >
        <button id="searchBtn" onclick="searchJobs()">
            <span class="btn-label">Search</span>
            <span class="btn-arrow">→</span>
        </button>
    </div>
</div>

<!-- Results Area -->
<main class="results-area">

    <div class="loader" id="loader">
        <div class="loader-rings"></div>
        <p class="loader-text">Consulting the AI Oracle...</p>
    </div>

    <div class="error-box" id="errorBox">
        <div class="error-icon">⚠</div>
        <p class="error-title">Something went wrong</p>
        <p class="error-msg" id="errorMsg">Unable to fetch results. Please try again.</p>
    </div>

    <div class="empty-state" id="emptyState">
        <div class="empty-icon">🔎</div>
        <p class="empty-title">No results found</p>
        <p>Try a different search term or role description.</p>
    </div>

    <div class="results-header" id="resultsHeader">
        <span class="results-title" id="resultsLabel">Top Matches</span>
        <span class="results-count" id="resultsCount">0 results</span>
    </div>

    <div class="jobs-grid" id="jobsGrid"></div>

</main>

<!-- Footer -->
<footer>
    <span>&copy; 2024 Ashutosh Job Portal &nbsp;·&nbsp; All Rights Reserved</span>
</footer>

<script>
    document.getElementById('jobTypeInput').addEventListener('keydown', function(e) {
        if (e.key === 'Enter') searchJobs();
    });

    function setLoading(on) {
        document.getElementById('loader').classList.toggle('visible', on);
        document.getElementById('searchBtn').disabled = on;
    }

    function hideAll() {
        document.getElementById('loader').classList.remove('visible');
        document.getElementById('errorBox').classList.remove('visible');
        document.getElementById('emptyState').classList.remove('visible');
        document.getElementById('resultsHeader').classList.remove('visible');
        document.getElementById('jobsGrid').innerHTML = '';
    }

    function searchJobs() {
        var type = document.getElementById('jobTypeInput').value.trim();
        if (!type) { document.getElementById('jobTypeInput').focus(); return; }

        hideAll();
        setLoading(true);

        fetch('/findjob?type=' + encodeURIComponent(type), {
            method: 'GET',
            headers: { 'Accept': 'application/json' },
            credentials: 'same-origin'
        })
        .then(function(res) {
            if (!res.ok) throw new Error('Server error ' + res.status + '. Check your API key or server logs.');
            return res.json();
        })
        .then(function(jobs) {
            setLoading(false);
            if (!jobs || jobs.length === 0) {
                document.getElementById('emptyState').classList.add('visible');
                return;
            }
            document.getElementById('resultsLabel').textContent = 'Top matches for "' + escHtml(type) + '"';
            document.getElementById('resultsCount').textContent = jobs.length + ' result' + (jobs.length !== 1 ? 's' : '');
            document.getElementById('resultsHeader').classList.add('visible');

            var grid = document.getElementById('jobsGrid');
            jobs.forEach(function(job, i) { grid.appendChild(buildCard(job, i)); });
        })
        .catch(function(err) {
            setLoading(false);
            document.getElementById('errorBox').classList.add('visible');
            document.getElementById('errorMsg').textContent = err.message || 'Unable to fetch results. Please try again.';
        });
    }

    var avatarEmojis = ['💼','🏢','🚀','⚡','🎯'];

    function buildCard(job, index) {
        var card = document.createElement('div');
        card.className = 'job-card';
        card.style.animationDelay = (index * 90) + 'ms';

        var exp = job.reqExperience === 0
            ? 'Fresher / 0 yrs'
            : job.reqExperience + ' yr' + (job.reqExperience !== 1 ? 's' : '') + ' experience';

        var techChips = (job.postTechStack || []).map(function(t) {
            return '<span class="chip">' + escHtml(t) + '</span>';
        }).join('');

        card.innerHTML =
            '<div class="job-header">' +
                '<div class="company-avatar">' + avatarEmojis[index % avatarEmojis.length] + '</div>' +
                '<div class="job-meta">' +
                    '<p class="job-title">' + escHtml(job.postProfile || 'Untitled Role') + '</p>' +
                    '<span class="experience-badge">&#9203; ' + exp + '</span>' +
                '</div>' +
            '</div>' +
            '<p class="job-desc">' + escHtml(job.postDesc || '') + '</p>' +
            (techChips ? '<p class="tech-label">Tech Stack</p><div class="tech-chips">' + techChips + '</div>' : '');

        return card;
    }

    function escHtml(str) {
        return String(str)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;')
            .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    }
</script>

</body>
</html>
