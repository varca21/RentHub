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
                                <button type="button" class="btn btn-secondary"
                                    onclick="javascript:impostazioniAccount()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                        class="bi bi-gear" viewBox="0 0 16 16">
                                        <path
                                            d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492zM5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0z">
                                        </path>
                                        <path
                                            d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52l-.094-.319zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115l.094-.319z">
                                        </path>
                                    </svg>
                                </button>


                                <c:if test="${utenteLoggato.ruolo=='AMMINISTRATORE'}">

                                    <button type="button" class="btn btn-success"
                                        onclick="window.location.href='/amministrazione'">Amministrazione
                                    </button>
                                </c:if>



                                <!-- TASTO LOGOUT -->
                                <button type="button" class="btn btn-success" onclick="javascript:logout()">Logout
                                </button>

                            </c:if>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- NAV TABS -->
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="tab1-tab" data-toggle="tab" href="#tabCerca" role="tab"
                        aria-controls="tabCerca" aria-selected="true">
                        Cerca
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="tab2-tab" data-toggle="tab" href="#tabVendi" role="tab"
                        aria-controls="tabVendi" aria-selected="false">
                        Vendi
                    </a>
                </li>
            </ul>

            <div class="tab-content" id="myTabContent">
                <!-- TAB CERCA -->
                <div class="tab-pane p-4 fade show active" id="tabCerca" role="tabpanel" aria-labelledby="tab1-tab">
                    <nav class="navbar navbar-expand-lg navbar-light bg-light">
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item dropdown">
                                    <select class="custom-select">
                                        <option selected>Affito</option>
                                        <option selected>Vendita</option>
                                    </select>
                                    <select class="custom-select">
                                        <option selected>Seleziona tipologia</option>
                                        <c:forEach var="tipologia" items="${tipologie}">
                                            <option>${tipologia}</option>
                                        </c:forEach>
                                    </select>
                                </li>
                                <form class="d-flex">
                                    <input class="form-control me-2" type="search" placeholder="Search"
                                        aria-label="Search">
                                    <button class="btn btn-outline-success" type="submit">
                                        Cerca
                                    </button>
                                </form>
                            </ul>
                        </div>
                    </nav>
                </div>


                <!-- TAB VENDI -->
                <div class="tab-pane p-4 fade" id="tabVendi" role="tabpanel" aria-labelledby="tab3-tab">
                    <div class="card border-info mb-3">
                        <div class="card-header">
                            <center>Inserisci annuncio di vendita/affitto</center>
                        </div>
                        <c:if test="${utenteLoggato==null}">
                            <form method="POST" action="javascript:apriModalAccesso()">
                        </c:if>
                        <c:if test="${utenteLoggato!=null}">
                            <form method="POST" action="javascript:inserisciAnnuncio()">
                        </c:if>
                        <div class="form-group">
                            <label for="venditaTitolo">Titolo annuncio:</label>
                            <input type="text" class="form-control" placeholder="Inserisci titolo annuncio"
                                id="venditaTitolo" required>
                        </div>
                        <div class="form-group">
                            <label for="venditaDescrizione">Descrizione</label>
                            <textarea class="form-control" id="venditaDescrizione" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="venditaPrezzo">Prezzo:</label>
                            <input type="number" class="form-control" placeholder="Inserisci il prezzo"
                                id="venditaPrezzo" required>
                        </div>
                        <div class="form-group">
                            <label for="venditaMetriQuadri">Metri quadri:</label>
                            <input type="number" class="form-control" placeholder="Inserisci metri quadri"
                                id="venditaMetriQuadri" required>
                        </div>
                        <div class="form-group">
                            <label for="venditaFoto" class="form-label">Inserisci immagini</label>
                            <input class="form-control" type="file" id="venditaFoto"  accept="image/png, image/jpeg"  multiple required/>
                        </div>
                        <div class="form-group">
                            <label for="selezioneTipologiaVendita">Seleziona tipologia immobile</label>
                            <select class="custom-select" id="selezioneTipologiaVendita">
                                <option selected>Seleziona tipologia</option>
                                <c:forEach var="tipologia" items="${tipologie}">
                                    <option value=${tipologia}>${tipologia}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-4 ">
                                <label for="venditaIndirizzo">Indirizzo:</label>
                                <input type="text" class="form-control" placeholder="Inserisci via"
                                    id="venditaIndirizzo" required>
                            </div>
                            <div class="form-group col-md-4 ">
                                <label for="venditaCap">Cap:</label>
                                <input type="number" class="form-control" placeholder="Inserisci cap" id="venditaCap"
                                    required>
                            </div>
                            <div class="form-group col-md-4 ">
                                <label for="venditaCitta">Citta:</label>
                                <input type="text" class="form-control" placeholder="Inserisci citta" id="venditaCitta"
                                    required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="radioAffitta" value="affitto"
                                    checked>
                                <label class="form-check-label" for="radioAffitta">
                                    Affitta
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="radioAffitta" value="vendita">
                                <label class="form-check-label" for="radioCompra">
                                    Vendi
                                </label>
                            </div>
                        </div>

                        <center>

                            <button type="submit" class="btn btn-primary">Pubblica annuncio</button>
                        </center>
                        </form>
                    </div>
                </div>
            </div>



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
                                    <div class="invalid-feedback" id="messaggioValidazioneId">Account non esistente.
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Password:</label>
                                    <input type="password" class="form-control" placeholder="Inserisci password"
                                        id="pwd" required>
                                    <div class="invalid-feedback" id="messaggioValidazionePwd">Password errata.</div>
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
                                    <div class="invalid-feedback" id="messaggioValidazioneUserID">Id gia' esistente
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="emailreg">Email:</label>
                                    <input type="email" class="form-control" placeholder="Inserisci e-mail"
                                        id="emailreg" required>
                                    <div class="invalid-feedback" id="messaggioValidazioneEmailreg">email gia' esistente
                                    </div>
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
                                    <button type="submit" class="btn btn-primary"
                                        id="tastoRegistrati">Registrati</button>
                                </center>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </body>

        </html>