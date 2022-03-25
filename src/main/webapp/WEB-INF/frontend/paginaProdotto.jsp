<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>     
            <script src="/js/paginaProdotto.js"></script>
            <title>${annuncio.titolo} - renthub.com</title>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
            <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="/css/paginaProdotto.css">
            <script src="/js/paginaProdotto.js"></script>
        </head>

        <body>

            <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" />
            <div class="container">
                <!-- product -->
                <div class="product-content product-wrap clearfix product-deatil">
                    <div class="row">
                        <div class="col-md-5 col-sm-12 col-xs-12">
                            <div class="product-image">
                                <div id="myCarousel-2" class="carousel slide">
                                    <ol class="carousel-indicators">
                                        <c:forEach var="immagine" items="${immagini}" varStatus="loop">                                  
                                            <c:if test="${loop.index==0}">
                                                <li data-target="#myCarousel-2" data-slide-to="${loop}" class="active"></li>
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
                                                    <img src="${immagine}"class="immagini" alt="" />
                                                </div>
                                            </c:if>
                                            <c:if test="${loop.index!=0}">
                                                <div class="item">
                                                    <img src="${immagine}"class="immagini" alt="" />
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
                                    <p class="data">Pubblicato il ${annuncio.data}</p>
                            </c:if>
                        </div>

                        <div class="col-md-6 col-md-offset-1 col-sm-12 col-xs-12">
                            <h2 class="name">
                                ${annuncio.titolo}
                                <c:if test="${utenteLoggato.ruolo=='AMMINISTRATORE' ||utenteLoggato.idUtente==annuncio.utente.idUtente}">
                                    <button class="btn"><i class="fa fa-bars" data-toggle="modal" data-target="#modalModifica"></i></button>
                                </c:if>
                                <small>Annuncio di <a href="javascript:void(0);">${annuncio.utente.nome}</a></small>                
                            </h2>
                            <hr />
                            <h3 class="price-container">
                                &#8364; ${annuncio.prezzo}
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
                                <ul id="myTab" class="nav nav-pills">
                                    <li class="active"><a href="#more-information" data-toggle="tab"
                                            class="no-margin">Descrizione </a></li>
                                    <li class=""><a href="#specifiche" data-toggle="tab">Caratteristiche</a></li>
                                    <li class=""><a href="#reviews" data-toggle="tab">Recensioni</a></li>
                                </ul>
                                <div id="myTabContent" class="tab-content">
                                    <div class="tab-pane fade active in" id="more-information">
                                        <br />
                                        <strong>Descrizione</strong>
                                        <p>
                                            ${annuncio.descrizione}
                                        </p>
                                    </div>
                                    <div class="tab-pane fade" id="specifiche">
                                        <br />
                                        <dl class="">
                                            <dt>Dimensione dell'immobile: </dt>
                                            <dd>${annuncio.metriQuadri} m&#178;</dd>
                                            <br />
                                            <dt>Tipologia immobile:</dt>
                                            <dd>${annuncio.tipologia}</dd>
                                            <br />
                                            <dt>Indirizzo:</dt>
                                            <dd>${annuncio.posizione.indirizzo} , ${annuncio.posizione.citta}</dd>
                                            <br />
                                            <dt>CAP:</dt>
                                            <dd>${annuncio.posizione.cap} </dd>
                                            <br />
                                            <iframe src="https://maps.google.com/maps?q=10.305385,77.923029&hl=es;z=14&amp;output=embed" width="400" height="250" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                        </dl>
                                    </div>
                                    <div class="tab-pane fade" id="reviews">
                                        <br />
                                        <c:if test="${utenteLoggato!=null}">
                                            <form onsubmit="aggiungiRecensione()" >
                                                <textarea rows="2" class="form-control" required
                                                    placeholder="Scrivi una recensione" id="recensione"></textarea>
                                                <div class="margin-top-100">
                                                    <button type="submit" class="btn btn-sm btn-primary pull-right" >
                                                        Inserisci recensione
                                                    </button>                                                                                                                                                
                                                </div>
                                            </form>
                                            </br>
                                            </br>
                                        </c:if>          
                                        <div class="chat-body">
                                            <ul>
                                                <c:forEach var="recensione" items="${recensioni}">
                                                    <li class="message">                                   
                                                        <span class="message-text">
                                                            <a href="javascript:void(0);" class="username">
                                                                ${recensione.utente.nome} ${recensione.utente.cognome}                                                      
                                                            </a>
                                                            </br>
                                                            ${recensione.descrizione}
                                                        </span>      
                                                    </li> 
                                                </c:forEach>
                                                                                 
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-sm-12 col-md-6 col-lg-6">
                                    <button class="btn btn-white btn-default"><i class="fa fa-envelope"></i> Contatta il
                                        venditore</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- MODAL LOGIN -->
            <div class="modal fade" id="modalModifica">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><center>MODIFICA ARTICOLO</center></h4
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
                                    <textarea class="form-control"  id="venditaDescrizione" rows="3">${annuncio.descrizione}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="venditaMetriQuadri">Metri quadri:</label>
                                    <input type="number" class="form-control" placeholder="Inserisci metri quadri"
                                        id="venditaMetriQuadri" value="${annuncio.metriQuadri}" required>
                                </div>
                                <div class="form-group">
                                    <label for="venditaMetriQuadri">Prezzo:</label>
                                    <input type="number" class="form-control" placeholder="Inserisci prezzo"
                                        id="venditaPrezzo" value="${annuncio.prezzo}" required>
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
                                        <input type="number" class="form-control" placeholder="Inserisci cap" id="venditaCap"
                                        value="${annuncio.posizione.cap}" required>
                                    </div>
                                    <div class="form-group col-md-4 ">
                                        <label for="venditaCitta">Citta:</label>
                                        <input type="text" class="form-control" placeholder="Inserisci citta" id="venditaCitta"
                                        value="${annuncio.posizione.citta}" required>
                                    </div>
                                </div>
                                <center>
                                    <button type="submit" class="btn btn-primary"
                                        onclick="javascript:modificaAnnuncio()" id="tastoRegistrati">Salva</button>
                                </center>                           
                            </form>
                        </div>                
                    </div>
                </div>
            </div>

          

        </body>

        </html>