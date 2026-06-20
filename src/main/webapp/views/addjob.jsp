<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ashutosh Job Portal - Post a Job</title>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --black:#050000; --deep:#0d0000; --void:#130000; --dark-red:#1c0000;
            --mid-red:#3d0000; --blood:#7a0000; --crimson:#a80000; --glow:#cc1a00;
            --ember:#e63000; --muted:#7a4040; --text-dim:#a06060;
            --text-main:#d4a0a0; --text-light:#f0d0d0;
        }
        html, body { min-height: 100vh; background: var(--black); color: var(--text-main); font-family: 'Inter', sans-serif; }

        /* NAV */
        nav {
            position: sticky; top: 0; z-index: 100;
            background: rgba(5,0,0,0.94); backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(163,0,0,0.22);
            padding: 0 2rem;
        }
        .nav-inner { max-width: 1000px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; height: 60px; }
        .nav-brand { font-family: 'Cinzel', serif; font-size: 1.05rem; font-weight: 700; color: var(--text-light); text-decoration: none; display: flex; align-items: center; gap: 9px; letter-spacing: .07em; }
        .brand-orb { width: 22px; height: 22px; border-radius: 50%; background: radial-gradient(circle at 38% 36%, #e63000, #3d0000 62%); box-shadow: 0 0 10px rgba(200,40,0,.55); flex-shrink: 0; }
        .nav-links { display: flex; gap: 2rem; list-style: none; }
        .nav-links a { color: var(--text-dim); text-decoration: none; font-size: .82rem; font-weight: 500; letter-spacing: .05em; transition: color .2s; }
        .nav-links a:hover { color: var(--text-light); }

        /* HERO BANNER */
        .hero-banner {
            position: relative; overflow: hidden;
            background: linear-gradient(to bottom, var(--black) 0%, var(--void) 100%);
            border-bottom: 1px solid rgba(100,0,0,0.3);
            display: flex; align-items: center; justify-content: center;
            padding: 2.5rem 2rem 0;
            min-height: 320px;
        }
        /* Moon glow behind samurai */
        .hero-banner::before {
            content: '';
            position: absolute;
            bottom: 0; left: 50%; transform: translateX(-50%);
            width: 360px; height: 360px; border-radius: 50%;
            background: radial-gradient(circle at 50% 50%, rgba(140,0,0,0.22) 0%, transparent 70%);
            pointer-events: none;
        }
        .banner-text { position: relative; z-index: 2; text-align: center; max-width: 420px; padding-bottom: 2rem; }
        .banner-eyebrow { font-family: 'Cinzel', serif; font-size: .62rem; letter-spacing: .28em; color: var(--crimson); text-transform: uppercase; margin-bottom: .75rem; }
        .banner-title { font-family: 'Cinzel', serif; font-size: clamp(1.5rem,3.5vw,2.1rem); font-weight: 700; color: var(--text-light); line-height: 1.2; margin-bottom: .75rem; }
        .banner-title span { color: var(--ember); }
        .banner-sub { font-size: .85rem; font-weight: 300; color: var(--text-dim); line-height: 1.6; }

        .samurai-wrap { position: relative; z-index: 2; flex-shrink: 0; }

        /* FORM WRAPPER */
        .form-section { padding: 3rem 2rem 5rem; }
        .form-container { max-width: 700px; margin: 0 auto; }

        /* SECTION LABEL */
        .section-label {
            font-family: 'Cinzel', serif; font-size: .65rem; letter-spacing: .25em;
            color: var(--blood); text-transform: uppercase;
            margin-bottom: 1.5rem;
            display: flex; align-items: center; gap: .75rem;
        }
        .section-label::after { content: ''; flex: 1; height: 1px; background: linear-gradient(to right, rgba(100,0,0,.4), transparent); }

        /* FORM GRID */
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem; margin-bottom: 1.25rem; }
        .form-group { margin-bottom: 1.25rem; }

        label {
            display: block; font-size: .78rem; font-weight: 500;
            color: var(--text-dim); margin-bottom: .45rem; letter-spacing: .04em;
        }

        input[type="text"], input[type="number"], textarea, select {
            width: 100%;
            background: var(--void);
            border: 1px solid rgba(100,0,0,.35);
            border-radius: 3px;
            padding: .7rem .9rem;
            color: var(--text-light);
            font-family: 'Inter', sans-serif;
            font-size: .88rem;
            font-weight: 300;
            transition: border-color .2s, box-shadow .2s;
            outline: none;
            -webkit-appearance: none;
        }
        input[type="text"]:focus, input[type="number"]:focus, textarea:focus, select:focus {
            border-color: rgba(180,30,0,.6);
            box-shadow: 0 0 0 3px rgba(120,0,0,.15);
        }
        input::placeholder, textarea::placeholder { color: var(--muted); }
        textarea { resize: vertical; min-height: 110px; }
        select[multiple] { height: 180px; cursor: pointer; }
        select option { background: var(--dark-red); color: var(--text-main); padding: 4px 8px; }
        select option:checked { background: var(--blood); color: var(--text-light); }

        /* HINT TEXT */
        .field-hint { font-size: .72rem; color: var(--muted); margin-top: .35rem; }

        /* SUBMIT */
        .submit-wrap { margin-top: 2rem; }
        .btn-submit {
            width: 100%;
            padding: .85rem 2rem;
            background: var(--blood);
            color: var(--text-light);
            font-family: 'Cinzel', serif;
            font-size: .8rem; font-weight: 600;
            letter-spacing: .14em;
            border: 1px solid var(--crimson);
            border-radius: 2px;
            cursor: pointer;
            box-shadow: 0 0 18px rgba(140,0,0,.3);
            transition: all .25s;
        }
        .btn-submit:hover { background: var(--crimson); box-shadow: 0 0 30px rgba(190,26,0,.5); color: #fff; }

        /* CORNER ACCENT on form container */
        .form-card {
            position: relative;
            background: var(--void);
            border: 1px solid rgba(100,0,0,.3);
            border-radius: 3px;
            padding: 2.5rem;
        }
        .form-card::before {
            content: ''; position: absolute; top: 0; left: 0;
            width: 44px; height: 44px;
            border-top: 1px solid var(--crimson);
            border-left: 1px solid var(--crimson);
            opacity: .5;
        }
        .form-card::after {
            content: ''; position: absolute; bottom: 0; right: 0;
            width: 44px; height: 44px;
            border-bottom: 1px solid var(--crimson);
            border-right: 1px solid var(--crimson);
            opacity: .5;
        }

        footer { text-align: center; padding: 2rem; border-top: 1px solid rgba(70,0,0,.3); color: var(--muted); font-size: .75rem; letter-spacing: .05em; }

        @media (max-width: 600px) {
            .form-row { grid-template-columns: 1fr; }
            .hero-banner { flex-direction: column; }
            .nav-links { display: none; }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <div class="nav-inner">
        <a class="nav-brand" href="#">
            <div class="brand-orb"></div>
            Ashutosh Portal
        </a>
        <ul class="nav-links">
            <li><a href="home">Home</a></li>
            <li><a href="viewalljobs">All Jobs</a></li>
            <li><a href="contact">Contact</a></li>
        </ul>
    </div>
</nav>

<!-- Hero Banner with Samurai -->
<div class="hero-banner">
    <!-- Text left -->
    <div class="banner-text">
        <p class="banner-eyebrow">∙ &nbsp; Forge Your Team &nbsp; ∙</p>
        <h1 class="banner-title">Post a <span>New</span> Opening</h1>
        <p class="banner-sub">Summon the finest talent from across the land. Fill in the details below to publish your opening.</p>
    </div>

    <!-- Samurai SVG -->
    <div class="samurai-wrap">
        <svg width="240" height="310" viewBox="0 0 240 310" fill="none" xmlns="http://www.w3.org/2000/svg">

            <!-- Blood moon disc behind samurai -->
            <circle cx="120" cy="130" r="88" fill="#1a0000"/>
            <circle cx="120" cy="130" r="88" fill="none" stroke="#5c0000" stroke-width="1.5"/>
            <!-- Moon glow ring -->
            <circle cx="120" cy="130" r="94" fill="none" stroke="rgba(140,0,0,0.3)" stroke-width="3"/>
            <circle cx="120" cy="130" r="100" fill="none" stroke="rgba(100,0,0,0.15)" stroke-width="4"/>

            <!-- Moon surface subtle lines -->
            <path d="M60 90 Q90 85 100 110" stroke="#2a0000" stroke-width="1" fill="none"/>
            <path d="M140 155 Q160 148 175 160" stroke="#2a0000" stroke-width="0.8" fill="none"/>
            <path d="M75 155 Q85 165 95 160" stroke="#2a0000" stroke-width="0.8" fill="none"/>

            <!-- === SAMURAI SILHOUETTE === -->
            <!-- Legs -->
            <path d="M100 255 L100 290 Q100 295 97 295 L94 295 Q91 295 91 290 L91 255 Z" fill="#0d0000"/>
            <path d="M140 255 L140 290 Q140 295 143 295 L146 295 Q149 295 149 290 L149 255 Z" fill="#0d0000"/>

            <!-- Wide hakama (skirt) -->
            <path d="M88 200 Q85 230 88 255 L152 255 Q155 230 152 200 Z" fill="#120000"/>
            <path d="M88 200 L152 200 Q148 225 120 228 Q92 225 88 200 Z" fill="#0d0000"/>
            <!-- Hakama folds -->
            <line x1="105" y1="205" x2="105" y2="252" stroke="#1c0000" stroke-width="1"/>
            <line x1="120" y1="202" x2="120" y2="253" stroke="#1c0000" stroke-width="1"/>
            <line x1="135" y1="205" x2="135" y2="252" stroke="#1c0000" stroke-width="1"/>

            <!-- Torso / Do (chest armour) -->
            <path d="M95 160 L95 205 L145 205 L145 160 Q145 150 120 148 Q95 150 95 160 Z" fill="#1c0000"/>
            <!-- Armour plate lines -->
            <line x1="95" y1="172" x2="145" y2="172" stroke="#2e0000" stroke-width="1"/>
            <line x1="95" y1="184" x2="145" y2="184" stroke="#2e0000" stroke-width="1"/>
            <line x1="95" y1="196" x2="145" y2="196" stroke="#2e0000" stroke-width="1"/>
            <!-- Vertical rivets -->
            <line x1="108" y1="160" x2="108" y2="204" stroke="#2a0000" stroke-width="0.8"/>
            <line x1="132" y1="160" x2="132" y2="204" stroke="#2a0000" stroke-width="0.8"/>

            <!-- Left shoulder guard (O-sode) -->
            <path d="M72 155 Q65 152 62 158 L58 175 Q57 183 65 185 L88 183 L90 160 Z" fill="#1c0000"/>
            <line x1="62" y1="163" x2="88" y2="162" stroke="#2e0000" stroke-width="0.8"/>
            <line x1="61" y1="170" x2="88" y2="169" stroke="#2e0000" stroke-width="0.8"/>
            <line x1="60" y1="177" x2="87" y2="176" stroke="#2e0000" stroke-width="0.8"/>

            <!-- Right shoulder guard -->
            <path d="M168 155 Q175 152 178 158 L182 175 Q183 183 175 185 L152 183 L150 160 Z" fill="#1c0000"/>
            <line x1="178" y1="163" x2="152" y2="162" stroke="#2e0000" stroke-width="0.8"/>
            <line x1="179" y1="170" x2="152" y2="169" stroke="#2e0000" stroke-width="0.8"/>
            <line x1="180" y1="177" x2="153" y2="176" stroke="#2e0000" stroke-width="0.8"/>

            <!-- Left arm -->
            <path d="M72 158 Q68 170 66 185 Q65 195 70 198 L80 196 L88 183 L90 162 Z" fill="#160000"/>
            <!-- Right arm -->
            <path d="M168 158 Q172 170 174 185 Q175 195 170 198 L160 196 L152 183 L150 162 Z" fill="#160000"/>

            <!-- Left hand / glove -->
            <ellipse cx="69" cy="200" rx="7" ry="5" fill="#0d0000"/>
            <!-- Right hand -->
            <ellipse cx="171" cy="200" rx="7" ry="5" fill="#0d0000"/>

            <!-- KATANA — held in right hand, blade angled up-left diagonally -->
            <!-- Tsuka (handle) -->
            <path d="M168 198 L182 175" stroke="#2a0000" stroke-width="5" stroke-linecap="round"/>
            <!-- Tsuba (guard circle) -->
            <circle cx="178" cy="180" r="5" fill="#3d0000" stroke="#5c0000" stroke-width="1"/>
            <!-- Blade — long diagonal -->
            <path d="M178 176 L118 72" stroke="#5c0000" stroke-width="2" stroke-linecap="round"/>
            <!-- Blade shine -->
            <path d="M177 174 L117 70" stroke="#a00000" stroke-width="0.8" stroke-linecap="round" opacity="0.5"/>
            <!-- Blade tip -->
            <path d="M118 72 L114 68 L122 70 Z" fill="#7a0000"/>

            <!-- Neck -->
            <rect x="113" y="132" width="14" height="18" rx="3" fill="#160000"/>

            <!-- Head (kabuto helmet) -->
            <!-- Main dome -->
            <path d="M90 115 Q90 82 120 80 Q150 82 150 115 L150 130 Q150 140 120 140 Q90 140 90 130 Z" fill="#1c0000"/>
            <!-- Helmet shikoro (neck guard plates) -->
            <path d="M90 128 Q85 132 83 138 Q88 145 120 145 Q152 145 157 138 Q155 132 150 128 Z" fill="#160000"/>
            <line x1="83" y1="133" x2="157" y2="133" stroke="#2a0000" stroke-width="0.8"/>
            <line x1="83" y1="138" x2="157" y2="138" stroke="#2a0000" stroke-width="0.8"/>

            <!-- Maedate (front crest — crescent horn) -->
            <path d="M110 82 Q108 68 115 62 Q122 56 120 72" stroke="#5c0000" stroke-width="2" fill="none" stroke-linecap="round"/>
            <path d="M130 82 Q132 68 125 62 Q118 56 120 72" stroke="#5c0000" stroke-width="2" fill="none" stroke-linecap="round"/>

            <!-- Helmet ridge lines (suji kabuto) -->
            <path d="M120 81 L120 115" stroke="#2e0000" stroke-width="0.8"/>
            <path d="M104 84 Q102 100 100 115" stroke="#2e0000" stroke-width="0.8" fill="none"/>
            <path d="M136 84 Q138 100 140 115" stroke="#2e0000" stroke-width="0.8" fill="none"/>
            <path d="M94 94 Q93 105 92 115" stroke="#2e0000" stroke-width="0.8" fill="none"/>
            <path d="M146 94 Q147 105 148 115" stroke="#2e0000" stroke-width="0.8" fill="none"/>

            <!-- Menpo (face mask) -->
            <path d="M96 118 Q96 132 100 136 Q108 140 120 140 Q132 140 140 136 Q144 132 144 118" fill="#130000" stroke="#2a0000" stroke-width="0.8"/>
            <!-- Mask nostrils (fierce face) -->
            <ellipse cx="113" cy="128" rx="3" ry="2" fill="#1c0000" stroke="#3d0000" stroke-width="0.8"/>
            <ellipse cx="127" cy="128" rx="3" ry="2" fill="#1c0000" stroke="#3d0000" stroke-width="0.8"/>
            <!-- Mask angry brow slits -->
            <path d="M100 120 L110 123" stroke="#5c0000" stroke-width="1" stroke-linecap="round"/>
            <path d="M140 120 L130 123" stroke="#5c0000" stroke-width="1" stroke-linecap="round"/>
            <!-- Eye slits glowing red -->
            <path d="M100 122 L112 125" stroke="#a80000" stroke-width="1.5" stroke-linecap="round"/>
            <path d="M140 122 L128 125" stroke="#a80000" stroke-width="1.5" stroke-linecap="round"/>

            <!-- Sode (hanging shoulder straps / tassets) -->
            <rect x="90" y="200" width="16" height="28" rx="2" fill="#160000" stroke="#2a0000" stroke-width="0.5"/>
            <rect x="134" y="200" width="16" height="28" rx="2" fill="#160000" stroke="#2a0000" stroke-width="0.5"/>
            <line x1="90" y1="207" x2="106" y2="207" stroke="#2e0000" stroke-width="0.6"/>
            <line x1="90" y1="214" x2="106" y2="214" stroke="#2e0000" stroke-width="0.6"/>
            <line x1="90" y1="221" x2="106" y2="221" stroke="#2e0000" stroke-width="0.6"/>
            <line x1="134" y1="207" x2="150" y2="207" stroke="#2e0000" stroke-width="0.6"/>
            <line x1="134" y1="214" x2="150" y2="214" stroke="#2e0000" stroke-width="0.6"/>
            <line x1="134" y1="221" x2="150" y2="221" stroke="#2e0000" stroke-width="0.6"/>

            <!-- Ground shadow -->
            <ellipse cx="120" cy="297" rx="48" ry="6" fill="#0d0000"/>

            <!-- Floating ember sparks near blade -->
            <circle cx="148" cy="110" r="1.5" fill="#a80000" opacity="0.7"/>
            <circle cx="138" cy="96" r="1" fill="#cc1a00" opacity="0.6"/>
            <circle cx="155" cy="100" r="1" fill="#7a0000" opacity="0.5"/>
            <circle cx="130" cy="85" r="1.2" fill="#a80000" opacity="0.55"/>
        </svg>
    </div>
</div>

<!-- Form Section -->
<div class="form-section">
    <div class="form-container">

        <div class="form-card">
            <div class="section-label">Posting Details</div>

            <form action="handleForm" method="post">

                <!-- Row 1: ID + Experience -->
                <div class="form-row">
                    <div class="form-group" style="margin-bottom:0;">
                        <label for="postId"># Post ID</label>
                        <input type="text" id="postId" name="postId" placeholder="e.g. JOB-101" required>
                    </div>
                    <div class="form-group" style="margin-bottom:0;">
                        <label for="reqExperience">Required Experience (Years)</label>
                        <input type="number" id="reqExperience" name="reqExperience" placeholder="e.g. 3" min="0" required>
                    </div>
                </div>

                <!-- Row 2: Job Title -->
                <div class="form-group">
                    <label for="postProfile">Post Profile — Job Title</label>
                    <input type="text" id="postProfile" name="postProfile" placeholder="e.g. Senior Kotlin Developer" required>
                </div>

                <!-- Row 3: Description -->
                <div class="form-group">
                    <label for="postDesc">Post Description</label>
                    <textarea id="postDesc" name="postDesc" rows="4" placeholder="Describe the role, responsibilities, and perks..." required></textarea>
                </div>

                <!-- Row 4: Tech Stack -->
                <div class="form-group">
                    <label for="postTechStack">Tech Stack Requirements</label>
                    <select multiple id="postTechStack" name="postTechStack" required>
                        <option value="Java">Java</option>
                        <option value="JavaScript">JavaScript</option>
                        <option value="TypeScript">TypeScript</option>
                        <option value="HTML5">HTML5</option>
                        <option value="CSS3">CSS3</option>
                        <option value="Node.js">Node.js</option>
                        <option value="Express.js">Express.js</option>
                        <option value="React Native">React Native</option>
                        <option value="Angular">Angular</option>
                        <option value="Vue.js">Vue.js</option>
                        <option value="Python">Python</option>
                        <option value="Django">Django</option>
                        <option value="Flask">Flask</option>
                        <option value="PHP">PHP</option>
                        <option value="Laravel">Laravel</option>
                        <option value="Ruby on Rails">Ruby on Rails</option>
                        <option value="Go">Go</option>
                        <option value="Rust">Rust</option>
                        <option value="Swift">Swift</option>
                        <option value="Kotlin">Kotlin</option>
                        <option value="Flutter">Flutter</option>
                        <option value="GraphQL">GraphQL</option>
                        <option value="Apache Kafka">Apache Kafka</option>
                        <option value="Elasticsearch">Elasticsearch</option>
                        <option value="AWS">AWS (Amazon Web Services)</option>
                        <option value="Azure">Azure</option>
                        <option value="Google Cloud">Google Cloud</option>
                        <option value="Docker">Docker</option>
                        <option value="Kubernetes">Kubernetes</option>
                        <option value="Jenkins">Jenkins</option>
                        <option value="DevOps">DevOps</option>
                        <option value="Machine Learning">Machine Learning</option>
                        <option value="Artificial Intelligence">Artificial Intelligence</option>
                        <option value="TensorFlow">TensorFlow</option>
                        <option value="PyTorch">PyTorch</option>
                        <option value="Blockchain">Blockchain</option>
                        <option value="Cybersecurity">Cybersecurity</option>
                        <option value="Unity">Unity</option>
                        <option value="Game Development">Game Development</option>
                        <option value="Agile">Agile</option>
                        <option value="Scrum">Scrum</option>
                        <option value="Kanban">Kanban</option>
                    </select>
                    <p class="field-hint">Hold Ctrl / Cmd to select multiple technologies</p>
                </div>

                <!-- Submit -->
                <div class="submit-wrap">
                    <button type="submit" class="btn-submit">&#9654;&nbsp;&nbsp;Publish Job Opening</button>
                </div>

            </form>
        </div>
    </div>
</div>

<footer>
    <span>&copy; 2024 Ashutosh Job Portal &nbsp;·&nbsp; All Rights Reserved</span>
</footer>

</body>
</html>