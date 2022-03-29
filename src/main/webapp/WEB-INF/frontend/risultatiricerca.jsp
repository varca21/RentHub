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
        </head>

        <body>
            <div class="container">
                <div class="bg-white rounded d-flex align-items-center justify-content-between" id="header"> <button class="btn btn-hide text-uppercase" type="button" data-toggle="collapse" data-target="#filterbar" aria-expanded="false" aria-controls="filterbar" id="filter-btn" > <span class="fas fa-angle-left" id="filter-angle"></span> <span id="btn-txt">Nascondi filtri</span> </button>                                               </div>
                <div id="content" class="my-5">
                    <div id="filterbar" class="collapse">                                                   
                        <div class="box border-bottom">
                            <div> <label class="tick">Vendita <input type="checkbox"  onclick="cambioFiltri()" id="checkVendita" > <span class="check"></span> </label> </div>
                            <div> <label class="tick">Affitto <input type="checkbox"  onclick="cambioFiltri()" id="checkAffitto"> <span class="check"></span> </label> </div>
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
                                <button class="btn ml-auto" type="button" data-toggle="collapse" data-target="#inner-box" aria-expanded="false" aria-controls="inner-box" id="out" onclick="outerFilter()"> <span class="fas fa-plus"></span> </button> </div>
                            <div id="inner-box" class="collapse mt-2 mr-1">
                                <div class="my-1"> <label class="tick">Windbreaker <input type="checkbox" checked="checked"> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Jumpsuit <input type="checkbox"> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Jacket <input type="checkbox"> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Coat <input type="checkbox"> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Raincoat <input type="checkbox"> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Handbag <input type="checkbox" checked> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Warm vest <input type="checkbox"> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Wallets <input type="checkbox" checked> <span class="check"></span> </label> </div>
                            </div>
                        </div>
                        <div class="box border-bottom">
                            TO-BE: ORDINAMENTO PER PREZZO
                        </div>
                        <div class="box border-bottom">
                            TO-BE: ORDINAMENTO METRI QUADRI
                        </div>                   
                    </div>
                    <div>
                        <div class="row mx-0"  id="prodotti">
                            <c:forEach var="annuncio" items="${risultatiRicerca}">
                                <div class="col-lg-4 col-md-6">
                                    <div class="card d-flex flex-column align-items-center" >
                                        <a class="stretched-link" href="/annuncio/${annuncio.idAnnuncio}" textdecoration-none>
                                            <div class="text-muted text-center mt-auto">${annuncio.tipologia}</div>   
                                            <div class="card-img"> <img src="${annuncio.fotoCopertina}" alt=""> </div>
                                            <div class="card-body pt-5 ">
                                                <div class="product-name ">${annuncio.titolo}</div>
                                                <div class="text-muted  mt-auto">${annuncio.posizione.indirizzo},${annuncio.posizione.citta}</div>   
                                                <div class="d-flex align-items-center price">
                                                    <c:if test="${annuncio.prezzoScontato!=0}">
                                                        <div class="del mr-2"><span class="text-dark">${annuncio.prezzo}&#8364;</span></div>
                                                        <div class="font-weight-bold">${annuncio.prezzoScontato}&nbsp;</div>                                   
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