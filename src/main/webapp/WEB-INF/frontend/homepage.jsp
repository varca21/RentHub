<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <html>

        <head>
            <script src="/js/script.js"></script>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        </head>

        <body>

            <!--BARRA DI NAVIGAZIONE-->
            <nav class="navbar navbar-expand-sm bg-dark navbar-dark">

                <div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <button type="button" class="btn btn-success" data-toggle="modal"
                                data-target="#Accedi">Login</button>
                        </li>
                    </ul>
                </div>
            </nav>


            <!-- MODAL LOGIN -->
            <div class="modal fade" id="Accedi">
                <div class="modal-dialog">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">ACCEDI</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">
                            <form action="/action_page.php">
                                <div class="form-group">
                                    <label for="email">Email o ID Utente:</label>
                                    <input type="email" class="form-control" placeholder="Inserisci e-mail o ID Utente"
                                        id="email" required>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Password:</label>
                                    <input type="password" class="form-control" placeholder="Inserisci password"
                                        id="pwd" required>
                                </div>

                                <center>
                                    <button type="submit" class="btn btn-primary">Accedi</button>
                                </center>
                            </form>
                        </div>

                        <center>
                            <a href="#Registrazione" data-toggle="modal" data-dismiss="modal"
                                data-target="#Registrazione">Non sei ancora registrato? Registrati!</a>
                        </center>
                    </div>
                </div>
            </div>


            <!-- MODAL REGISTRAZIONE -->
            <div class="modal fade" id="Registrazione">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">REGISTRATI</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">
                            <form method="POST" action="javascript:registra()">
                                <div class="form-group">
                                    <label for="userID">ID Utente:</label>
                                    <input type="text" class="form-control" placeholder="Inserisci ID Utente"
                                        id="userID" required>
                                </div>
                                <div class="form-group">
                                    <label for="emailreg">Email:</label>
                                    <input type="email" class="form-control" placeholder="Inserisci e-mail"
                                        id="emailreg" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password:</label>
                                    <input type="password" class="form-control" placeholder="Inserisci password"
                                        id="password" required>
                                </div>
                                <div class="form-group">
                                    <label for="nome">Nome:</label>
                                    <input type="text" class="form-control" placeholder="Inserisci nome" id="nome"
                                        required>
                                </div>
                                <div class="form-group">
                                    <label for="cognome">Cognome:</label>
                                    <input type="text" class="form-control" placeholder="Inserisci cognome"
                                        id="cognome">
                                </div>
                                <div class="form-group">
                                    <label for="dataNascita">Data di nascita:</label>
                                    <input type="date" class="form-control" placeholder="Inserisci data di nascita"
                                        id="dataNascita">
                                </div>
                                <div class="form-group">
                                    <label for="numTel">Numero di telefono:</label>
                                    <input type="text" class="form-control" placeholder="Inserisci numero di telefono"
                                        id="numTel">
                                </div>

                                <center>
                                    <button type="submit" class="btn btn-primary">Registrati</button>
                                </center>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </body>

        </html>