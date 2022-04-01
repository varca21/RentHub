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
            <div class="container">
                <div class="bg-dark rounded d-flex align-items-center justify-content-between" id="header">
                    <button class="btn btn-hide text-uppercase" type="button" data-toggle="collapse" data-target="#filterbar" aria-expanded="false" aria-controls="filterbar" id="filter-btn"> 
                        <span class="fas fa-angle-left" id="filter-angle"></span> 
                        <span id="btn-txt">Nascondi filtri</span> 
                    </button>
                    <a href="/"><img src="/immagini/logo/logo.png" height=60 > </a>                       
                </div>
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
                                <select class="custom-select" id="selezioneTipologiaVendita" onchange="cambioFiltri()">
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
                        <div class="row mx-0" id="prodotti">
                            <c:forEach var="annuncio" items="${risultatiRicerca}">
                                <div class="col-lg-4 col-md-6">
                                    <div class="card d-flex flex-column align-items-center">
                                        <a class="stretched-link" href="/annuncio/${annuncio.idAnnuncio}"
                                            textdecoration-none>
                                            <div class="text-muted text-center mt-auto">${annuncio.tipologia}</div>
                                            <div class="card-img"> <img src="${annuncio.fotoCopertina}" alt=""> </div>
                                            <div class="card-body pt-5 ">
                                                <div class="product-name ">${annuncio.titolo}</div>
                                                <div class="text-muted  mt-auto">
                                                    ${annuncio.posizione.indirizzo},${annuncio.posizione.citta}</div>
                                                <div class="d-flex align-items-center price">
                                                    <c:if test="${annuncio.prezzoScontato!=0}">
                                                        <div class="del mr-2"><span
                                                                class="text-dark">${annuncio.prezzo}&#8364;</span></div>
                                                        <div class="font-weight-bold">${annuncio.prezzoScontato}&nbsp;
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

        </html>