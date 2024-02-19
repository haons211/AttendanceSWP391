<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login in FPT</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <style>
            .gradient-custom-2 {
                /* fallback for old browsers */
                background: #fccb90;

                /* Chrome 10-25, Safari 5.1-6 */
                background: -webkit-linear-gradient(to right,#f8f4ec,#FFC0D9, #FF90BC);

                /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
                background: linear-gradient(to right, #f8f4ec,#FFC0D9, #FF90BC);
            }

            @media (min-width: 768px) {
                .gradient-form {
                    height: 100vh !important;
                }
            }
            @media (min-width: 769px) {
                .gradient-custom-2 {
                    border-top-right-radius: .3rem;
                    border-bottom-right-radius: .3rem;
                }
            }
        </style>
    </head>
    <body>
        <form action="Login" method="POST">  
            <section class="h-100 gradient-form" style="background-color: #eee;">
                <div class="container py-5 h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-xl-10">
                            <div class="card rounded-3 text-black">
                                <div class="row g-0">
                                    <div class="col-lg-6">
                                        <div class="card-body p-md-5 mx-md-4">

                                            <div class="text-center">
                                                <img src="assets/img/pngtree-hacker-logo-png-image_6408677.png"
                                                     style="width: 185px;" alt="logo">
                                                <h4 class="mt-1 mb-5 pb-1"></h4>
                                            </div>
                                            <form>
                                                <div class="form-outline mb-4">
                                                    <label class="form-label" for="form2Example11">Username</label>
                                                    <input type="text" id="form2Example11" class="form-control"
                                                           placeholder="Employee ID or Staff ID" name="txtUsername" />

                                                </div>

                                                <div class="form-outline mb-4">
                                                    <label class="form-label" for="form2Example22" >Password</label>
                                                    <input type="password" id="form2Example22" class="form-control" placeholder="password" name="txtPassword" />

                                                </div>
                                                <%
                                           String errorMessage = (String) request.getAttribute("error"); 
                                           if(errorMessage != null){ 
                                                %>
                                                <p class="error" style="color: red"><%= errorMessage %></p>  
                                                <%
                                                  }
                                                %>
                                                <div class="text-center pt-1 mb-5 pb-1">
                                                    <button style="color: black"class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3"
                                                            type="submit">Log in</button>
                                                    <a class="text-muted" href="#!">Forgot password?</a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
                                        <div class="text-white px-3 py-4 p-md-5 mx-md-4">
                                            <h3 style="color: black"class="mb-4">We are more than just a company</h3>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </form>
        <!-- Show error if any -->
    </div>
</body>
</html>
