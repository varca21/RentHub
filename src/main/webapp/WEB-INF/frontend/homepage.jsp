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
                            <c:if test="${utenteLoggato==null}">
                                <!-- TASTO LOGIN -->
                                <button type="button" class="btn btn-success" data-toggle="modal"
                                    data-target="#Accedi">Login</button>
                            </c:if>
                            <c:if test="${utenteLoggato!=null}">
                                Ciao ${utenteLoggato.nome}!
                                <!-- TASTO IMPOSTAZIONI -->
                                <button type="button" class="btn btn-secondary" onclick="javascript:impostazioniAccount()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"class="bi bi-gear" viewBox="0 0 16 16">                                 
                                        <path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492zM5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0z"></path>
                                        <path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52l-.094-.319zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115l.094-.319z"></path>
                                    </svg>
                                </button>
                                <!-- TASTO LOGOUT -->
                                <button type="button" class="btn btn-success"
                                    onclick="javascript:logout()">Logout</button>

                            </c:if>
                        </li>
                    </ul>
                </div>
            </nav>


            <!-- MODAL LOGIN -->
            <div class="modal fade" id="Accedi">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">ACCEDI</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">
                            <form action="javascript:login()">
                                <div class="form-group">
                                    <label for="email">Email o ID Utente:</label>
                                    <input type="text" class="form-control" placeholder="Inserisci e-mail o ID Utente"
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
                            <a href="#modalRegistrazione" data-toggle="modal" data-dismiss="modal"
                                data-target="#modalRegistrazione">Non sei ancora registrato? Registrati!</a>
                        </center>
                    </div>
                </div>
            </div>


            <!-- MODAL REGISTRAZIONE -->
            <div class="modal fade" id="modalRegistrazione">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title titoloRegistrazione">REGISTRATI</h4>
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
                                    <label for="password" id="labelPassword">Password:</label>
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
                                    <button type="submit" class="btn btn-primary" id="tastoRegistrati">Registrati</button>
                                </center>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </body>

        </html>