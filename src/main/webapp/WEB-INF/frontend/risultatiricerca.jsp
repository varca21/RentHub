<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
            <link rel="stylesheet" href="/css/risultatiricerca.css">
            <script src="/js/risultatiRicerca.js"></script>
            <script src="/js/login.js"></script>
        </head>

        <body>
            

            <div>
                <div class="container">
                    <!--BARRA DI NAVIGAZIONE-->
                    <nav class="navbar navbar-expand-sm bg-dark navbar-dark" id="header">
                        <div class="navbar-collapse">
                       
                            
                            <a href="/"><img src="/immagini/logo/logo.png" height=60> </a>
                            <button class="btn btn-hide text-uppercase" type="button" data-toggle="collapse"
                                data-target="#filterbar" aria-expanded="false" aria-controls="filterbar" id="filter-btn">
                                <span class="fas fa-angle-left" id="filter-angle"></span>
                                <span id="btn-txt">Nascondi filtri</span>
                            </button>
                      
                            <ul class="navbar-nav ml-auto ">
                                <li class="nav-item">
                                </li>
                                <c:if test="${utenteLoggato==null}">
                                    <li class="nav-item">
                                        <button class="btn  tastologin" type="button" data-toggle="modal"
                                            data-target="#Accedi">login</button>
                                    </li>
                                </c:if>
                                <c:if test="${utenteLoggato!=null}">
                                    <li class="nav-item px-3">
                                        <div class="row">

                                            <div class="saluto">Ciao,${utenteLoggato.nome}!</div>
                                            <button class="btn  tastologin" onclick="javascript:logout()"><a
                                                id="tastologin">Logout</a></button>
                                            </div>
                                    </li>
                                 
                                </c:if>                                        
                            </ul>
                        </div>
                    </nav>
                    <div id="content" class="my-5">
                        <div id="filterbar" class="collapse">
                            <div class="box border-bottom">
                                <div> <label class="tick">Vendita <input type="checkbox" onclick="cambioFiltri()"
                                            id="checkVendita"> <span class="check"></span> </label> </div>
                                <div> <label class="tick">Affitto <input type="checkbox" onclick="cambioFiltri()"
                                            id="checkAffitto"> <span class="check"></span> </label> </div>
                            </div>
                            <div class="box border-bottom">
                                Tipologia immobile:
                                <div class="box-label text-uppercase d-flex align-items-center">
                                    <select class="custom-select" id="selezioneTipologiaVendita"
                                        onchange="cambioFiltri()">
                                        <option selected></option>
                                        <c:forEach var="tipologia" items="${tipologie}">
                                            <option value=${tipologia}>${tipologia}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="box border-bottom">
                                Ordina per:
                                <select class="custom-select" id="selezioneFiltri" onchange="cambioFiltri()">
                                    <option value="nessuno " selected></option>
                                    <option value="prezzodown">Prezzo &#8595 <i class="fas fa-sort"></i></option>
                                    <option value="metridown">Metri Quadri &#8595 </option>
                                </select>
                            </div>
                        </div>
                        <div>
                            <div class="row mx-0 " id="prodotti">
                                <c:forEach var="annuncio" items="${risultatiRicerca}">
                                    <div class="col-lg-4 col-md-6 p-2">
                                        <div class="card d-flex flex-column align-items-center">
                                            <a class="stretched-link" href="/annuncio/${annuncio.idAnnuncio}"
                                                textdecoration-none>
                                                <div class="text-muted text-center mt-auto">${annuncio.tipologia}
                                                </div>
                                                <div class="card-img"> <img src="${annuncio.fotoCopertina}" alt="">
                                                </div>
                                                <div class="card-body pt-5 ">
                                                    <div class="product-name ">${annuncio.titolo}</div>
                                                    <div class="text-muted  mt-auto">
                                                        ${annuncio.posizione.indirizzo},${annuncio.posizione.citta}
                                                    </div>
                                                    <div class="d-flex align-items-center price">
                                                        <c:if test="${annuncio.prezzoScontato!=0}">
                                                            <div class="del mr-2"><span
                                                                    class="text-dark">${annuncio.prezzo}&#8364;</span>
                                                            </div>
                                                            <div class="font-weight-bold">
                                                                ${annuncio.prezzoScontato}&nbsp;
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${annuncio.prezzoScontato==0}">
                                                            ${annuncio.prezzo}
                                                        </c:if>
                                                        &#8364;
                                                        <c:if test="${annuncio.affitto}">
                                                            <small> &nbsp; al mese</small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
        </body>

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
                                <label for="idlogin">Email o ID Utente:</label>
                                <input type="text" class="form-control" placeholder="Inserisci e-mail o ID Utente"
                                    id="idlogin" required>
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
                                <button type="submit" class="btn tastocerca">Accedi</button>
                            </center>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        </html>