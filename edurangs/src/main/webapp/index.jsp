<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko" data-bs-theme="auto">
  <head>
	<script type="text/javascript">
		location.href = "/edurang/main.do";   
	</script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">
    <title>Headers · Bootstrap v5.3</title>

	<!-- 이하는 로컬 이용하는방법
	    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/headers/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
	<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
	-->
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" 
	      rel="stylesheet" 
	      integrity="sha384-..." 
	      crossorigin="anonymous">
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
	        integrity="sha384-VlE0FB7x1ErP4FqZt7aV1fYrU0a4i6FzR5jH5smg5UnpXn5Zc7p4yl2zR3K8twE5" 
	        crossorigin="anonymous"></script>

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        width: 100%;
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }

      .btn-bd-primary {
        --bd-violet-bg: #712cf9;
        --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

        --bs-btn-font-weight: 600;
        --bs-btn-color: var(--bs-white);
        --bs-btn-bg: var(--bd-violet-bg);
        --bs-btn-border-color: var(--bd-violet-bg);
        --bs-btn-hover-color: var(--bs-white);
        --bs-btn-hover-bg: #6528e0;
        --bs-btn-hover-border-color: #6528e0;
        --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
        --bs-btn-active-color: var(--bs-btn-hover-color);
        --bs-btn-active-bg: #5a23c8;
        --bs-btn-active-border-color: #5a23c8;
      }

      .bd-mode-toggle {
        z-index: 1500;
      }

      .bd-mode-toggle .dropdown-menu .active .bi {
        display: block !important;
      }
            body {
          font-family: Arial, sans-serif;
          line-height: 1.6;
          margin: 0;
          padding: 20px;
      }        
        
		.container-wrapper {
		    display: flex;
		    flex-wrap: wrap; /* 화면이 작아지면 줄바꿈 */
		    gap: 20px; /* 컨테이너 간 간격 */
		    justify-content: center; /* 가운데 정렬 */
		}
		
		/* 컨테이너 기본 스타일 */
		.container {
		    width: 600px; /* 컨테이너 너비 */
		    border: 1px solid #ccc;
		    padding: 10px;
		    box-sizing: border-box;
		}
		
		/* 반응형 스타일: 화면 너비가 850px 이하일 때 세로 정렬 */
		@media (max-width: 768px) {
		    .container-wrapper {
		        flex-direction: column; /* 세로 배치 */
		        align-items: center; /* 가운데 정렬 */
		    }
		}
		
        h2 {
            text-align: center;
        }
        .header {
		    display: flex;
		    align-items: center;
		    justify-content: space-between; /* 제목과 버튼을 양쪽 정렬 */
		    margin-bottom: 10px;
		}
        .board {
            border: 1px solid #ddd;
            margin-top: 20px;
        }
        .board-header {
            background-color: #f4f4f4;
            padding: 10px;
            font-weight: bold;
        }
        .board-row {
            display: flex;
            border-bottom: 1px solid #ddd;
            padding: 10px;
        }
        .board-row:last-child {
            border-bottom: none;
        }
        .board-column {
            flex: 1;
        }
        .board-column.small {
            flex: 0 0 100px;
        }
        .write-button {
            display: block;
            width: 100px;
            margin: 20px 0 0 auto;
            padding: 10px;
            background-color: #007bff;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="headers.css" rel="stylesheet">
  </head>
  <body>
    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
      <symbol id="check2" viewBox="0 0 16 16">
        <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
      </symbol>
      <symbol id="circle-half" viewBox="0 0 16 16">
        <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>
      </symbol>
      <symbol id="moon-stars-fill" viewBox="0 0 16 16">
        <path d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z"/>
        <path d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z"/>
      </symbol>
      <symbol id="sun-fill" viewBox="0 0 16 16">
        <path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
      </symbol>
    </svg>

    <div class="dropdown position-fixed bottom-0 end-0 mb-3 me-3 bd-mode-toggle">
      <button class="btn btn-bd-primary py-2 dropdown-toggle d-flex align-items-center"
              id="bd-theme"
              type="button"
              aria-expanded="false"
              data-bs-toggle="dropdown"
              aria-label="Toggle theme (auto)">
        <svg class="bi my-1 theme-icon-active" width="1em" height="1em"><use href="#circle-half"></use></svg>
        <span class="visually-hidden" id="bd-theme-text">Toggle theme</span>
      </button>
      <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="bd-theme-text">
        <li>
          <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="light" aria-pressed="false">
            <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#sun-fill"></use></svg>
            Light
            <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
          </button>
        </li>
        <li>
          <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="dark" aria-pressed="false">
            <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#moon-stars-fill"></use></svg>
            Dark
            <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
          </button>
        </li>
        <li>
          <button type="button" class="dropdown-item d-flex align-items-center active" data-bs-theme-value="auto" aria-pressed="true">
            <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#circle-half"></use></svg>
            Auto
            <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
          </button>
        </li>
      </ul>
    </div>

    
<svg xmlns="http://www.w3.org/2000/svg" class="d-none">
  <symbol id="bootstrap" viewBox="0 0 118 94">
    <title>Bootstrap</title>
    <path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z"></path>
  </symbol>
  <symbol id="home" viewBox="0 0 16 16">
    <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"/>
  </symbol>
  <symbol id="speedometer2" viewBox="0 0 16 16">
    <path d="M8 4a.5.5 0 0 1 .5.5V6a.5.5 0 0 1-1 0V4.5A.5.5 0 0 1 8 4zM3.732 5.732a.5.5 0 0 1 .707 0l.915.914a.5.5 0 1 1-.708.708l-.914-.915a.5.5 0 0 1 0-.707zM2 10a.5.5 0 0 1 .5-.5h1.586a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 10zm9.5 0a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 1 0 1H12a.5.5 0 0 1-.5-.5zm.754-4.246a.389.389 0 0 0-.527-.02L7.547 9.31a.91.91 0 1 0 1.302 1.258l3.434-4.297a.389.389 0 0 0-.029-.518z"/>
    <path fill-rule="evenodd" d="M0 10a8 8 0 1 1 15.547 2.661c-.442 1.253-1.845 1.602-2.932 1.25C11.309 13.488 9.475 13 8 13c-1.474 0-3.31.488-4.615.911-1.087.352-2.49.003-2.932-1.25A7.988 7.988 0 0 1 0 10zm8-7a7 7 0 0 0-6.603 9.329c.203.575.923.876 1.68.63C4.397 12.533 6.358 12 8 12s3.604.532 4.923.96c.757.245 1.477-.056 1.68-.631A7 7 0 0 0 8 3z"/>
  </symbol>
  <symbol id="table" viewBox="0 0 16 16">
    <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"/>
  </symbol>
  <symbol id="people-circle" viewBox="0 0 16 16">
    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
  </symbol>
  <symbol id="grid" viewBox="0 0 16 16">
    <path d="M1 2.5A1.5 1.5 0 0 1 2.5 1h3A1.5 1.5 0 0 1 7 2.5v3A1.5 1.5 0 0 1 5.5 7h-3A1.5 1.5 0 0 1 1 5.5v-3zM2.5 2a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 1h3A1.5 1.5 0 0 1 15 2.5v3A1.5 1.5 0 0 1 13.5 7h-3A1.5 1.5 0 0 1 9 5.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zM1 10.5A1.5 1.5 0 0 1 2.5 9h3A1.5 1.5 0 0 1 7 10.5v3A1.5 1.5 0 0 1 5.5 15h-3A1.5 1.5 0 0 1 1 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 9h3a1.5 1.5 0 0 1 1.5 1.5v3a1.5 1.5 0 0 1-1.5 1.5h-3A1.5 1.5 0 0 1 9 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"/>
  </symbol>
</svg>

<main>
  <h1 class="visually-hidden">Header</h1>

  <header class="this header">
    <div class="container-fluid d-flex flex-wrap justify-content-center">
        <a href="/" class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto link-body-emphasis text-decoration-none">
            <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
            <span class="fs-4">이거로 씁시다 Double header</span>
        </a>
        <form class="col-12 col-lg-auto mb-3 mb-lg-0" role="search">
            <input type="search" class="form-control" placeholder="Search..." aria-label="Search">
        </form>
        <button type="button" class="btn btn-outline-primary me-2">Login</button>
        <button type="button" class="btn btn-warning">Sign-up</button>
    </div>
</header>
    <nav class="py-2 bg-body-tertiary border-bottom">
    <div class="container d-flex flex-wrap">
      <ul class="nav me-auto">
        <li class="nav-item"><a href="#" class="nav-link link-body-emphasis px-2 active" aria-current="page">Home</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-body-emphasis px-2">Features</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-body-emphasis px-2">Pricing</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-body-emphasis px-2">FAQs</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-body-emphasis px-2">this About</a></li>
      </ul>
    </div>
  </nav>
  <div class="container-wrapper">
	  <div class="container">
	        <div class="header">
	        <h2>HOT</h2>
	        <a href="#" class="write-button">더보기</a>
	    </div>
	        <div class="board">
	            <div class="board-header">
	                <div class="board-row">
	                    <div class="board-column small">No.</div>
	                    <div class="board-column">Title</div>
	                    <div class="board-column small">Author</div>
	                    <div class="board-column small">Date</div>
	                </div>
	            </div>
	            <div class="board-row">
                <div class="board-column small">3</div>
                <div class="board-column"><a href="main.do">메인</a></div>
                <div class="board-column small">Admin</div>
                <div class="board-column small">2025-02-24</div>
            </div>
            <div class="board-row">
                <div class="board-column small">3</div>
                <div class="board-column"><a href="bbs/list.do">글목록</a></div>
                <div class="board-column small">Admin</div>
                <div class="board-column small">2025-02-24</div>
            </div>
            <div class="board-row">
                <div class="board-column small">3</div>
                <div class="board-column"><a href="bbs/list.do?m=view">글</a></div>
                <div class="board-column small">Admin</div>
                <div class="board-column small">2025-02-24</div>
            </div>
            <div class="board-row">
                <div class="board-column small">3</div>
                <div class="board-column"><a href="bbs/list.do?m=input">글작성</a></div>
                <div class="board-column small">Admin</div>
                <div class="board-column small">2025-02-24</div>
            </div>
            <div class="board-row">
                <div class="board-column small">3</div>
                <div class="board-column"><a href="login/login.do?m=form">회원가입</a></div>
                <div class="board-column small">Admin</div>
                <div class="board-column small">2025-02-24</div>
            </div>
            <div class="board-row">
                <div class="board-column small">3</div>
                <div class="board-column"><a href="login/login.do">로그인</a></div>
                <div class="board-column small">Admin</div>
                <div class="board-column small">2025-02-24</div>
            </div>
	         <div class="board-row">
                <div class="board-column small">3</div>
                <div class="board-column"><a href="login/login.do?m=editProfile">회원정보 수정</a></div>
                <div class="board-column small">Admin</div>
                <div class="board-column small">2025-02-24</div>
            </div>
   	         <div class="board-row">
                <div class="board-column small">3</div>
                <div class="board-column"><a href="login/test.jsp">로그인 후 세션 확인</a></div>
                <div class="board-column small">Admin</div>
                <div class="board-column small">2025-02-24</div>
            </div>
	        
	    </div>
	    <!-- 옆에 위치하는 컨테이너-->
	    <div class="container">
	        <div class="header">
	        <h2>최근 게시글</h2>
	        <a href="#" class="write-button">더보기</a>
	    </div>
	        <div class="board">
	            <div class="board-header">
	                <div class="board-row">
	                    <div class="board-column small">No.</div>
	                    <div class="board-column">Title</div>
	                    <div class="board-column small">Author</div>
	                    <div class="board-column small">Date</div>
	                </div>
	            </div>
	            <div class="board-row">
                <div class="board-column small">3</div>
                <div class="board-column">Welcome to our bulletin board</div>
                <div class="board-column small">Admin</div>
                <div class="board-column small">2025-02-24</div>
            </div>
	        </div>
	    </div>
	    
</div>
	  
<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
