<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <script src="/js/paginaAnnuncio.js"></script>
            <script src="/js/login.js"></script>
            <title>${annuncio.titolo} - renthub.com</title>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
            <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" />
            <link rel="stylesheet" href="/css/paginaAnnuncio.css">
            <script src="/js/paginaAnnuncio.js"></script>
        </head>

        <body>
            <div class="share-btn-container">
                <a href="#" id="facebook-btn">
                    <i class="fa fa-facebook-official" aria-hidden="true"></i>
                </a>
            
                <a href="#" id="twitter-btn">
                    <i class="fa fa-twitter" aria-hidden="true"></i>
                </a>     
            
                <a href="#" id="whatsapp-btn">
                    <i class="fa fa-whatsapp" aria-hidden="true"></i>
                </a>
            </div>

            <div class="container">
                <nav class="navbar navbar-scura">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a href="/"><img class="tst" src="/immagini/logo/logo.png" height="50"> </a>
                        </div>

                        <ul class="nav test navbar-nav inte navbar-right">
                            <c:if test="${utenteLoggato==null}">
                                <!-- TASTO LOGIN -->
                                <li class="tasto" data-toggle="modal" data-target="#Accedi"><a class="login">Login</a></li>
                            </c:if>
                            <c:if test="${utenteLoggato!=null}">
                                <li><div class="saluto">Ciao,${utenteLoggato.nome}!</div></li>
                                <!-- TASTO LOGOUT -->
                                <li class="tasto" onclick="javascript:logout()"><a  id="tastologin">Logout</a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </nav>

                <!-- product -->
                <div class="product-content product-wrap clearfix product-deatil">
                    <div class="row">
                        <div class="col-md-5 col-sm-12 col-xs-12">
                            <div class="product-image">
                                <div id="myCarousel-2" class="carousel slide ">
                                    <ol class="carousel-indicators">
                                        <c:forEach var="immagine" items="${immagini}" varStatus="loop">
                                            <c:if test="${loop.index==0}">
                                                <li data-target="#myCarousel-2" data-slide-to="${loop}" class="active">
                                                </li>
                                            </c:if>
                                            <c:if test="${loop.index!=0}">
                                                <li data-target="#myCarousel-2" data-slide-to="${loop}" class=""></li>
                                            </c:if>
                                        </c:forEach>
                                    </ol>
                                    <div class="carousel-inner">
                                        <c:forEach var="immagine" items="${immagini}" varStatus="loop">
                                            <c:if test="${loop.index==0}">
                                                <div class="item active">
                                                    <img src="${immagine}" class="immagini" alt="" />
                                                </div>
                                            </c:if>
                                            <c:if test="${loop.index!=0}">
                                                <div class="item">
                                                    <img src="${immagine}" class="immagini" alt="" />
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <a class="left carousel-control" href="#myCarousel-2" data-slide="prev"> <span
                                            class="glyphicon glyphicon-chevron-left"></span> </a>
                                    <a class="right carousel-control" href="#myCarousel-2" data-slide="next"> <span
                                            class="glyphicon glyphicon-chevron-right"></span> </a>
                                </div>
                            </div>
                            <c:if test="${annuncio.data!=null}">
                                <p class="data sottotitoli">Pubblicato il ${annuncio.data}</p>
                            </c:if>
                        </div>

                        <div class="col-md-6 col-md-offset-1 col-sm-12 col-xs-12">
                            <h2 class="name">
                                ${annuncio.titolo}
                                <c:if
                                    test="${utenteLoggato.ruolo=='AMMINISTRATORE' ||utenteLoggato.idUtente==annuncio.utente.idUtente}">
                                    <button class="btn"><i class="fa fa-bars" data-toggle="modal"
                                            data-target="#modalModifica"></i></button>
                                    <button class="btn"><i class="fa fa-trash" data-toggle="modal"
                                            data-target="#modalConfermaEliminazione"></i></button>
                                </c:if>
                                <small>Annuncio di <a
                                        href="javascript:visualizzaInfoUtente('${annuncio.utente.idUtente}');">${annuncio.utente.idUtente}</a></small>
                            </h2>
                            <hr />
                            <h3 class="price-container">
                                &#8364;
                                <c:if test="${annuncio.prezzoScontato!=0}">
                                    <span class="strike">${annuncio.prezzo}</span> ${annuncio.prezzoScontato}
                                </c:if>
                                <c:if test="${annuncio.prezzoScontato==0}">
                                    ${annuncio.prezzo}
                                </c:if>
                                <c:if test="${annuncio.affitto}">
                                    <small>al mese</small>
                                </c:if>

                            </h3>
                            <c:if test="${annuncio.affitto}">
                                <label.tipologia><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        fill="currentColor" class="bi bi-tag" viewBox="0 0 16 16">
                                        <path
                                            d="M6 4.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-1 0a.5.5 0 1 0-1 0 .5.5 0 0 0 1 0z" />
                                        <path
                                            d="M2 1h4.586a1 1 0 0 1 .707.293l7 7a1 1 0 0 1 0 1.414l-4.586 4.586a1 1 0 0 1-1.414 0l-7-7A1 1 0 0 1 1 6.586V2a1 1 0 0 1 1-1zm0 5.586 7 7L13.586 9l-7-7H2v4.586z" />
                                    </svg>Affitto</label>
                            </c:if>
                            <c:if test="${!annuncio.affitto}">
                                <label.tipologia><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        fill="currentColor" class="bi bi-tag" viewBox="0 0 16 16">
                                        <path
                                            d="M6 4.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-1 0a.5.5 0 1 0-1 0 .5.5 0 0 0 1 0z" />
                                        <path
                                            d="M2 1h4.586a1 1 0 0 1 .707.293l7 7a1 1 0 0 1 0 1.414l-4.586 4.586a1 1 0 0 1-1.414 0l-7-7A1 1 0 0 1 1 6.586V2a1 1 0 0 1 1-1zm0 5.586 7 7L13.586 9l-7-7H2v4.586z" />
                                    </svg> Vendita</label>
                            </c:if>
                            <hr />
                            <div class="description description-tabs">
                                <ul id="myTab" class="nav nav-pills ">
                                    <li class="active tasti"><a href="#more-information" data-toggle="tab"class="no-margin">Descrizione </a></li>
                                    <li class="tasti"><a href="#specifiche" data-toggle="tab">Caratteristiche</a></li>
                                    <li class="tasti"><a href="#reviews" data-toggle="tab">Recensioni</a></li>
                                </ul>
                                <div id="myTabContent" class="tab-content">
                                    <div class="tab-pane fade active in" id="more-information">
                                        <br />
                                        <strong class="titoli2">Descrizione</strong>
                                        <p class="sottotitoli">
                                            ${annuncio.descrizione}
                                        </p>
                                    </div>
                                    <div class="tab-pane fade" id="specifiche">
                                        <br />
                                        <dl class="">
                                            <dt class="titoli2">Dimensione dell'immobile: </dt>
                                            <dd class="sottotitoli">${annuncio.metriQuadri} m&#178;</dd>
                                            <br />
                                            <dt class="titoli2">Tipologia immobile:</dt>
                                            <dd class="sottotitoli">${annuncio.tipologia}</dd>
                                            <br />
                                            <dt class="titoli2">Indirizzo:</dt>
                                            <dd class="sottotitoli">${annuncio.posizione.indirizzo} , ${annuncio.posizione.citta}</dd>
                                            <br />
                                            <dt class="titoli2">CAP:</dt>
                                            <dd class="sottotitoli">${annuncio.posizione.cap} </dd>
                                            <br />
                                            <iframe
                                                src="https://maps.google.com/maps?q=10.305385,77.923029&hl=es;z=14&amp;output=embed"
                                                width="400" height="250" style="border:0;" allowfullscreen=""
                                                loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                        </dl>
                                    </div>
                                    <div class="tab-pane fade" id="reviews">
                                        <br />
                                        <c:if test="${utenteLoggato!=null}">
                                            <form>
                                                <textarea rows="2" class="form-control"
                                                    placeholder="Scrivi una recensione" id="recensione"
                                                    required></textarea>
                                                
                                                    
                                               
                                            </form>
                                            <button type="button" class="tastorecensioni"
                                                        onclick="aggiungiRecensione()">
                                                        Inserisci
                                                    </button>
                                            </br>
                                            </br>
                                        </c:if>
                                        <div class="chat-body">
                                            <ul id="listarecensioni">
                                                <c:forEach var="recensione" items="${recensioni}">
                                                    <li class="message">
                                                        <span class="message-text">
                                                            <a class="titoli " href="javascript:visualizzaInfoUtente('${recensione.utente.idUtente}');"
                                                                class="username">
                                                                ${recensione.utente.idUtente}
                                                            </a>
                                                            </br>
                                                            <div class="sottotitoli">${recensione.descrizione}</div>
                                                        </span>
                                                    </li>
                                                </c:forEach>

                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr />
                            <c:if test="${utenteLoggato!=null && utenteLoggato.idUtente!=annuncio.utente.idUtente}">
                                <div class="row">
                                    <div class="col-sm-12 col-md-6 col-lg-6">
                                        <button class="btn btn-white btn-default" data-toggle="modal"
                                            data-target="#modalContattaVenditore"><i class="fa fa-envelope"></i>
                                            Contatta il
                                            venditore
                                        </button>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
        </body>

        <!-- MODAL MODIFICA -->
        <div class="modal fade" id="modalModifica">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">
                            <center>MODIFICA ARTICOLO</center>
                        </h4>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <form method="POST" action="javascript:modificaAnnuncio">
                            <input type="hidden" value="${annuncio.idAnnuncio}" id="idAnnuncio" />
                            <input type="hidden" value="${utenteLoggato.idUtente}" id="idUtente" />
                            <div class="form-group">
                                <label for="venditaTitolo">Titolo annuncio:</label>
                                <input type="text" class="form-control" placeholder="Inserisci titolo annuncio"
                                    id="venditaTitolo" value="${annuncio.titolo}" required>
                            </div>
                            <div class="form-group">
                                <label for="venditaDescrizione">Descrizione:</label>
                                <textarea class="form-control" id="venditaDescrizione"
                                    rows="3">${annuncio.descrizione}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="venditaMetriQuadri">Metri quadri:</label>
                                <input type="number" class="form-control" placeholder="Inserisci metri quadri"
                                    id="venditaMetriQuadri" value="${annuncio.metriQuadri}" required>
                            </div>
                            <div class="form-group">
                                <label for="venditaPrezzo">Prezzo:</label>
                                <input type="number" class="form-control" placeholder="Inserisci prezzo"
                                    id="venditaPrezzo" value="${annuncio.prezzo}" required <c:if
                                    test="${utenteLoggato.idUtente!=annuncio.utente.idUtente}">disabled</c:if>
                                >
                            </div>
                            <div class="form-group">
                                <label for="venditaPrezzoScontato">Prezzo Scontato:</label>
                                <input type="number" class="form-control" placeholder="Inserisci prezzo scontato"
                                    id="venditaPrezzoScontato" value="${annuncio.prezzoScontato}" required <c:if
                                    test="${utenteLoggato.idUtente!=annuncio.utente.idUtente}">disabled</c:if>
                                >
                            </div>
                            <div class="form-group">
                                <label for="selezioneTipologiaVendita">Seleziona tipologia immobile</label>
                                <select class="custom-select" id="selezioneTipologiaVendita">
                                    <option selected>${annuncio.tipologia}</option>
                                    <c:forEach var="tipologia" items="${tipologie}">
                                        <c:if test="${tipologia!=annuncio.tipologia}">
                                            <option value=${tipologia}>${tipologia}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-4 ">
                                    <label for="venditaIndirizzo">Indirizzo:</label>
                                    <input type="text" class="form-control" placeholder="Inserisci via"
                                        id="venditaIndirizzo" value="${annuncio.posizione.indirizzo}" required>
                                </div>
                                <div class="form-group col-md-4 ">
                                    <label for="venditaCap">Cap:</label>
                                    <input type="number" class="form-control" placeholder="Inserisci cap"
                                        id="venditaCap" value="${annuncio.posizione.cap}" required>
                                </div>
                                <div class="form-group col-md-4 ">
                                    <label for="venditaCitta">Citta:</label>
                                    <input type="text" class="form-control" placeholder="Inserisci citta"
                                        id="venditaCitta" value="${annuncio.posizione.citta}" required>
                                </div>
                            </div>
                            <center>
                                <button type="submit" class="btn tastocerca" onclick="javascript:modificaAnnuncio()"
                                    id="tastoRegistrati">Salva</button>
                            </center>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- MODAL INFORMAZIONI UTENTE -->
        <div class="modal fade" id="modalInfoUtente">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">
                            <center>INFORMAZIONI UTENTE</center>
                        </h4>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="idU">ID Utente:</label>
                                <input type="text" class="form-control" id="idU" readonly>
                            </div>
                            <div class="form-group">
                                <label for="cognome">Cognome:</label>
                                <input type="text" class="form-control" id="cognome" readonly>
                            </div>
                            <div class="form-group">
                                <label for="nome">Nome:</label>
                                <input type="text" class="form-control" id="nome" readonly>
                            </div>
                            <div class="form-group">
                                <label for="">numTelefono:</label>
                                <input type="text" class="form-control" id="numTelefono" value="Non presente" readonly>
                            </div>
                            <div class="form-group">
                                <label for="email">E-mail:</label>
                                <input type="text" class="form-control" id="email" readonly>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!--Modal: modalConfirmDelete-->
        <div class="modal fade" id="modalConfermaEliminazione">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">
                            <center>Conferma eliminazione</center>
                        </h4>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body p-0">
                        <div class="card border-0 p-sm-3 p-2 justify-content-center">
                            <center>
                                <div class="card-header pb-0 bg-white border-0 ">
                                    <p class="font-weight-bold mb-2"> Sei sicuro di voler cancellare questo annuncio ?
                                    </p>
                                </div>
                                <div class="col-auto">
                                    <button type="button" class="btn btn-light text-muted"
                                        data-dismiss="modal">Annulla</button>
                                    <button type="button"
                                        onclick="javascript:cancellaAnnuncio('${annuncio.idAnnuncio}')"
                                        class="btn btn-danger px-4">Cancella</button>
                                </div>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- MODAL CONTATTA IL VENDITORE -->
        <div class="modal fade" id="modalContattaVenditore">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">
                            <center>CONTATTA IL VENDITORE</center>
                        </h4>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <form
                            action="javascript:contattaVenditore('${annuncio.utente.email}','${annuncio.idAnnuncio}')">
                            <div class="form-group">
                                <label for="messaggio">Inserisci il messaggio da inviare a
                                    ${annuncio.utente.idUtente}:</label>
                                <textarea id="messaggio" class="form-control"> </textarea> </br>
                                <center>
                                    <button type="submit" class="btn tastocerca">Invia</button>
                                </center>
                            </div>
                        </form>
                    </div>
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
                                    id="idlogin" required>
                                <div class="valid-feedback" id="messaggioValidazioneId">Account non esistente.</div>
                            </div>
                            <div class="form-group">
                                <label for="pwd">Password:</label>
                                <input type="password" class="form-control" placeholder="Inserisci password" id="pwd"
                                    required>
                                <div class="valid-feedback" id="messaggioValidazionePwd">Password errata.</div>
                            </div>

                            <center>
                                <button type="submit" class="btn tastocerca">Accedi</button>
                            </center>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        </html>