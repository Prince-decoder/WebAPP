<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Job Portal</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous">

    <style>
        /* Sci-Fi Theme Global Styles */
        body.sci-fi-theme {
            background: #000;
            background-image: url('file:///home/prince/Desktop/Prince/New%20folder/95233.jpg'); /* Your local path */
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        /* Navbar Styling */
        .bg-dark-sci-fi {
            background-color: #0c0000 !important;
            border-bottom: 2px solid #a00;
        }
        .navbar-dark .navbar-brand.text-sci-fi-red {
            color: #ff3333 !important;
            font-weight: 800;
            text-shadow: 0 0 10px #ff0000;
        }
        .navbar-dark .nav-link {
            color: #aaa !important;
        }
        .navbar-dark .nav-link:hover {
            color: #ff3333 !important;
        }

        /* Dramatic Header */
        .dramatic-header {
            color: #ff0000;
            text-shadow: 0 0 15px #ff0000, 0 0 5px #000;
            letter-spacing: 0.05em;
        }

        /* Sci-Fi Card Styling */
        .card-custom-sci-fi {
            background-color: rgba(20, 0, 0, 0.75) !important;
            border: 2px solid #a00 !important;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(160, 0, 0, 0.6);
            color: #eee !important;
            margin-bottom: 20px;
            backdrop-filter: blur(5px);
        }
        .card-custom-sci-fi .card-title.text-sci-fi-red {
            color: #ff4444 !important;
            text-shadow: 0 0 5px #ff0000;
            border-bottom: 1px solid rgba(255, 0, 0, 0.3);
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .card-custom-sci-fi .card-label {
            color: #ff6666;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 0.9em;
            letter-spacing: 1px;
        }

        /* Custom Hyperlink Styling for Sci-Fi Theme */
        .card-custom-sci-fi a.sci-fi-link {
            color: #ff3333;
            text-decoration: none;
            font-size: 1.1em;
            transition: all 0.3s ease;
        }
        .card-custom-sci-fi a.sci-fi-link:hover {
            color: #ffffff;
            text-shadow: 0 0 10px #ff0000, 0 0 20px #ff0000;
        }
    </style>

    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body class="sci-fi-theme">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark-sci-fi">
    <div class="container">
        <a class="navbar-brand fs-1 fw-medium text-sci-fi-red" href="#">Ashutosh Job Portal Web App</a>
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="viewalljobs">All Jobs</a></li>
                <li class="nav-item"><a class="nav-link" href="contact">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="mb-4 text-center font-weight-bold dramatic-header">Get In Touch</h2>

    <div class="row justify-content-center">
        <div class="col-md-6 mb-4">
            <div class="card card-custom-sci-fi">
                <div class="card-body text-center p-5">
                    <h5 class="card-title text-sci-fi-red fs-3">Contact Information</h5>

                    <div class="mt-4 mb-3">
                        <span class="card-label d-block mb-1">Phone Number</span>
                        <span class="fs-5">+91 9120409207</span>
                    </div>

                    <div class="mb-3">
                        <span class="card-label d-block mb-1">Address</span>
                        <span class="fs-5">IIIT Manipur, India</span>
                    </div>

                    <div class="mb-3">
                        <span class="card-label d-block mb-1">GitHub</span>
                        <a href="https://github.com/Prince-decoder" target="_blank" class="sci-fi-link">
                            Prince
                        </a>
                    </div>

                    <div class="mb-3">
                        <span class="card-label d-block mb-1">LinkedIn</span>
                        <a href="https://www.linkedin.com/in/prince-yadava/" target="_blank" class="sci-fi-link">
                            Prince Yadav
                        </a>
                    </div>

                </div>
                <div class="card-footer" style="border-top: 1px solid rgba(255, 0, 0, 0.3);">
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>
</html>