<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ashutosh Job Portal</title>
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
        .nav-links a:hover, .nav-links a.active { color: var(--text-light); }
        .nav-links a.active { border-bottom: 1px solid var(--crimson); padding-bottom: 2px; }

        /* ── HERO ── */
        .hero {
            position: relative; overflow: hidden;
            min-height: 480px;
            display: flex; align-items: center; justify-content: center;
            text-align: center;
            padding: 5rem 2rem 4rem;
        }
        /* Moon glow background */
        .hero::before {
            content: '';
            position: absolute; inset: 0;
            background:
                radial-gradient(ellipse 70% 60% at 50% 110%, rgba(140,0,0,0.5) 0%, transparent 65%),
                radial-gradient(ellipse 40% 30% at 50% 100%, rgba(200,30,0,0.25) 0%, transparent 60%),
                linear-gradient(to bottom, var(--black) 0%, var(--deep) 50%, var(--void) 100%);
            pointer-events: none;
        }
        /* Moon disc */
        .moon {
            position: absolute;
            bottom: -120px; left: 50%;
            transform: translateX(-50%);
            width: 420px; height: 420px;
            border-radius: 50%;
            background: radial-gradient(circle at 42% 38%, #5c0000, #1a0000 60%, #0a0000);
            box-shadow:
                0 0 0 2px rgba(180,30,0,0.3),
                0 0 40px 8px rgba(180,10,0,0.35),
                0 0 120px 30px rgba(140,0,0,0.2);
            pointer-events: none;
        }
        /* Moon surface texture veins */
        .moon::after {
            content: '';
            position: absolute; inset: 0;
            border-radius: 50%;
            background: repeating-conic-gradient(rgba(80,0,0,0.08) 0deg, transparent 2deg, transparent 15deg);
        }
        /* Bare branch silhouettes */
        .branch-left, .branch-right {
            position: absolute; bottom: 0;
            pointer-events: none;
            opacity: 0.6;
        }
        .branch-left { left: 0; }
        .branch-right { right: 0; transform: scaleX(-1); }

        .hero-content { position: relative; z-index: 2; max-width: 700px; width: 100%; }
        .hero-eyebrow {
            font-family: 'Cinzel', serif;
            font-size: 0.7rem; letter-spacing: 0.3em;
            color: var(--crimson);
            text-transform: uppercase;
            margin-bottom: 1.25rem;
        }
        .hero-title {
            font-family: 'Cinzel', serif;
            font-size: clamp(2rem, 5vw, 3.2rem);
            font-weight: 700;
            color: var(--text-light);
            line-height: 1.15;
            letter-spacing: 0.02em;
            margin-bottom: 1.25rem;
        }
        .hero-title span { color: var(--ember); }
        .hero-sub {
            font-size: 1rem; font-weight: 300;
            color: var(--text-dim);
            line-height: 1.7; max-width: 540px; margin: 0 auto;
        }

        /* ── SEARCH BAR ── */
        .search-wrap {
            position: relative; z-index: 2;
            max-width: 480px; margin: 2.25rem auto 0;
        }
        .search-form {
            display: flex; align-items: center;
            background: rgba(10,0,0,0.75);
            border: 1px solid rgba(160,0,0,0.45);
            border-radius: 3px;
            padding: 0.35rem 0.35rem 0.35rem 1.1rem;
            box-shadow: 0 0 0 1px rgba(0,0,0,0.4) inset, 0 0 22px rgba(140,0,0,0.18);
            transition: border-color 0.25s, box-shadow 0.25s;
        }
        .search-form:focus-within {
            border-color: var(--crimson);
            box-shadow: 0 0 0 1px rgba(0,0,0,0.4) inset, 0 0 28px rgba(200,26,0,0.35);
        }
        .search-icon {
            color: var(--muted);
            font-size: 0.95rem;
            margin-right: 0.65rem;
            flex-shrink: 0;
        }
        .search-input {
            flex: 1;
            background: transparent;
            border: none;
            outline: none;
            color: var(--text-light);
            font-family: 'Inter', sans-serif;
            font-size: 0.9rem;
            font-weight: 300;
            padding: 0.65rem 0;
        }
        .search-input::placeholder { color: var(--muted); }
        .search-btn {
            background: var(--blood);
            color: var(--text-light);
            border: 1px solid var(--crimson);
            font-family: 'Cinzel', serif;
            font-size: 0.7rem; font-weight: 600;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            padding: 0.65rem 1.4rem;
            border-radius: 2px;
            cursor: pointer;
            transition: background 0.25s, box-shadow 0.25s;
            white-space: nowrap;
        }
        .search-btn:hover {
            background: var(--crimson);
            box-shadow: 0 0 18px rgba(200,26,0,0.5);
            color: #fff;
        }

        /* ── DIVIDER ── */
        .divider {
            display: flex; align-items: center; gap: 1.5rem;
            max-width: 900px; margin: 3rem auto; padding: 0 2rem;
        }
        .divider-line { flex: 1; height: 1px; background: linear-gradient(to right, transparent, rgba(120,0,0,0.5), transparent); }
        .divider-icon { color: var(--blood); font-size: 0.7rem; letter-spacing: 0.2em; font-family: 'Cinzel', serif; white-space: nowrap; }

        /* ── CARDS ── */
        .cards-section { padding: 0 2rem 5rem; }
        .cards-grid {
            max-width: 900px; margin: 0 auto;
            display: grid; grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 1.5rem;
        }
        .card {
            position: relative; overflow: hidden;
            background: var(--void);
            border: 1px solid rgba(120,0,0,0.35);
            border-radius: 4px;
            padding: 2.5rem 2rem;
            text-align: center;
            transition: border-color 0.3s, transform 0.3s;
        }
        .card::before {
            content: '';
            position: absolute; inset: 0;
            background: radial-gradient(ellipse 80% 50% at 50% 100%, rgba(100,0,0,0.18) 0%, transparent 70%);
            pointer-events: none; transition: opacity 0.3s;
            opacity: 0;
        }
        .card:hover { border-color: rgba(200,40,0,0.55); transform: translateY(-3px); }
        .card:hover::before { opacity: 1; }

        /* Corner accent */
        .card::after {
            content: '';
            position: absolute; top: 0; left: 0;
            width: 40px; height: 40px;
            border-top: 1px solid var(--crimson);
            border-left: 1px solid var(--crimson);
            opacity: 0.5;
        }

        .card-icon {
            width: 56px; height: 56px;
            border-radius: 50%;
            margin: 0 auto 1.5rem;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.6rem;
        }
        .card-icon.find {
            background: rgba(100,0,0,0.25);
            border: 1px solid rgba(160,0,0,0.4);
            box-shadow: 0 0 20px rgba(180,0,0,0.15);
        }
        .card-icon.post {
            background: rgba(60,0,0,0.25);
            border: 1px solid rgba(100,0,0,0.4);
            box-shadow: 0 0 20px rgba(120,0,0,0.12);
        }

        .card-title {
            font-family: 'Cinzel', serif;
            font-size: 1.25rem; font-weight: 600;
            color: var(--text-light);
            letter-spacing: 0.04em;
            margin-bottom: 0.75rem;
        }
        .card-text {
            font-size: 0.9rem; font-weight: 300;
            color: var(--text-dim);
            line-height: 1.65;
            margin-bottom: 2rem;
        }

        /* ── BUTTONS ── */
        .btn {
            display: inline-block;
            padding: 0.75rem 2.25rem;
            font-family: 'Cinzel', serif;
            font-size: 0.8rem; font-weight: 600;
            letter-spacing: 0.12em;
            text-decoration: none;
            border-radius: 2px;
            transition: all 0.25s;
            cursor: pointer;
        }
        .btn-primary {
            background: var(--blood);
            color: var(--text-light);
            border: 1px solid var(--crimson);
            box-shadow: 0 0 16px rgba(160,0,0,0.35);
        }
        .btn-primary:hover {
            background: var(--crimson);
            box-shadow: 0 0 28px rgba(200,26,0,0.55);
            color: #fff;
        }
        .btn-outline {
            background: transparent;
            color: var(--text-main);
            border: 1px solid rgba(120,0,0,0.5);
        }
        .btn-outline:hover {
            border-color: var(--crimson);
            color: var(--text-light);
            background: rgba(80,0,0,0.18);
        }

        /* ── FOOTER ── */
        footer {
            text-align: center;
            padding: 2rem;
            border-top: 1px solid rgba(80,0,0,0.3);
            color: var(--muted);
            font-size: 0.78rem;
            letter-spacing: 0.05em;
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 600px) {
            .nav-links { display: none; }
            .moon { width: 280px; height: 280px; bottom: -80px; }
            .hero { min-height: 380px; }
            .search-wrap { max-width: 100%; }
            .search-form { flex-wrap: nowrap; }
            .search-btn { padding: 0.65rem 1rem; }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <div class="nav-inner">
        <a class="nav-brand" href="#">
            <div class="brand-icon"></div>
            Ashutosh Portal
        </a>
        <ul class="nav-links">
            <li><a href="home" class="active">Home</a></li>
            <li><a href="viewalljobs">All Jobs</a></li>
            <li><a href="findjob">AI Search</a></li>
            <li><a href="contact">Contact</a></li>
        </ul>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <!-- Moon disc -->
    <div class="moon"></div>

    <!-- Branch silhouettes -->
    <svg class="branch-left" width="220" height="320" viewBox="0 0 220 320" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M20 320 Q30 280 50 240 Q70 200 60 160 Q55 140 40 130" stroke="#3d0000" stroke-width="2.5" fill="none"/>
        <path d="M50 240 Q80 220 110 210" stroke="#3d0000" stroke-width="1.5" fill="none"/>
        <path d="M60 200 Q90 180 120 175 Q140 172 160 165" stroke="#3d0000" stroke-width="1.2" fill="none"/>
        <path d="M60 160 Q45 130 50 100 Q52 80 45 60" stroke="#3d0000" stroke-width="2" fill="none"/>
        <path d="M50 100 Q70 90 90 85" stroke="#3d0000" stroke-width="1" fill="none"/>
        <path d="M45 60 Q35 45 25 30 M45 60 Q55 40 60 20" stroke="#3d0000" stroke-width="1.2" fill="none"/>
        <path d="M0 280 Q20 260 30 230 Q40 200 20 180" stroke="#3d0000" stroke-width="1.8" fill="none"/>
        <path d="M30 230 Q50 215 75 208" stroke="#3d0000" stroke-width="1" fill="none"/>
    </svg>

    <svg class="branch-right" width="220" height="320" viewBox="0 0 220 320" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M20 320 Q30 280 50 240 Q70 200 60 160 Q55 140 40 130" stroke="#3d0000" stroke-width="2.5" fill="none"/>
        <path d="M50 240 Q80 220 110 210" stroke="#3d0000" stroke-width="1.5" fill="none"/>
        <path d="M60 200 Q90 180 120 175 Q140 172 160 165" stroke="#3d0000" stroke-width="1.2" fill="none"/>
        <path d="M60 160 Q45 130 50 100 Q52 80 45 60" stroke="#3d0000" stroke-width="2" fill="none"/>
        <path d="M50 100 Q70 90 90 85" stroke="#3d0000" stroke-width="1" fill="none"/>
        <path d="M45 60 Q35 45 25 30 M45 60 Q55 40 60 20" stroke="#3d0000" stroke-width="1.2" fill="none"/>
        <path d="M0 280 Q20 260 30 230 Q40 200 20 180" stroke="#3d0000" stroke-width="1.8" fill="none"/>
        <path d="M30 230 Q50 215 75 208" stroke="#3d0000" stroke-width="1" fill="none"/>
    </svg>

    <div class="hero-content">
        <p class="hero-eyebrow">∙ &nbsp; Opportunities Await &nbsp; ∙</p>
        <h1 class="hero-title">Welcome to<br><span>Ashutosh</span> Job Portal</h1>
        <p class="hero-sub">Find your dream role or hire the best talent in the industry. Your next opportunity rises now.</p>

        <!-- Search Bar -->
        <div class="search-wrap">
            <form class="search-form" id="jobSearchForm" onsubmit="return handleJobSearch(event)">
                <span class="search-icon">&#9737;</span>
                <input
                    type="text"
                    id="searchInput"
                    class="search-input"
                    placeholder="Search by title, skill, or keyword..."
                    autocomplete="off"
                    required
                >
                <button type="submit" class="search-btn">Seek</button>
            </form>
        </div>
    </div>
</section>

<!-- Divider -->
<div class="divider">
    <div class="divider-line"></div>
    <span class="divider-icon">⸻&nbsp;&nbsp;Choose Your Path&nbsp;&nbsp;⸻</span>
    <div class="divider-line"></div>
</div>

<!-- Action Cards -->
<section class="cards-section">
    <div class="cards-grid">
        <!-- Card 1 -->
        <div class="card">
            <div class="card-icon find">🔍</div>
            <h2 class="card-title">Find a Job</h2>
            <p class="card-text">Browse through hundreds of listings to find the perfect role that matches your skills and ambition.</p>
            <a href="/viewalljobs" class="btn btn-primary">View All Jobs</a>
        </div>

        <!-- Card 2 -->
        <div class="card">
            <div class="card-icon post">✦</div>
            <h2 class="card-title">Post a Job</h2>
            <p class="card-text">Are you an employer? Post an opening and connect with top-tier candidates from across the country.</p>
            <a href="/addjob" class="btn btn-outline">Add a Job</a>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <span>&copy; 2024 Ashutosh Job Portal &nbsp;·&nbsp; All Rights Reserved</span>
</footer>

<script>
    function handleJobSearch(event) {
        event.preventDefault();
        const input = document.getElementById('searchInput');
        const keyword = input.value.trim();
        if (!keyword) return false;
        window.location.href = 'http://localhost:8080/jobPosts/Keyword/' + encodeURIComponent(keyword);
        return false;
    }
</script>

</body>
</html>