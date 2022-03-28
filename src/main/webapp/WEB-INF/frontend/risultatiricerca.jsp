<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
            <link rel="stylesheet" href="/css/risultatiricerca.css">
        </head>

        <body>
            <div class="container">
                <div class="bg-white rounded d-flex align-items-center justify-content-between" id="header"> <button class="btn btn-hide text-uppercase" type="button" data-toggle="collapse" data-target="#filterbar" aria-expanded="false" aria-controls="filterbar" id="filter-btn" onclick="changeBtnTxt()"> <span class="fas fa-angle-left" id="filter-angle"></span> <span id="btn-txt">Nascondi filtri</span> </button>                                               </div>
                <div id="content" class="my-5">
                    <div id="filterbar" class="collapse">
                        <div class="box border-bottom">
                            <div class="form-group text-center">
                                <div class="btn-group" data-toggle="buttons"> <label class="btn btn-success form-check-label"> <input class="form-check-input" type="radio"> Reset </label> <label class="btn btn-success form-check-label active"> <input class="form-check-input" type="radio" checked> Apply </label> </div>
                            </div>
                            <div> <label class="tick">New <input type="checkbox" checked="checked"> <span class="check"></span> </label> </div>
                            <div> <label class="tick">Sale <input type="checkbox"> <span class="check"></span> </label> </div>
                        </div>
                        <div class="box border-bottom">
                            <div class="box-label text-uppercase d-flex align-items-center">Outerwear <button class="btn ml-auto" type="button" data-toggle="collapse" data-target="#inner-box" aria-expanded="false" aria-controls="inner-box" id="out" onclick="outerFilter()"> <span class="fas fa-plus"></span> </button> </div>
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
                            <div class="box-label text-uppercase d-flex align-items-center">season <button class="btn ml-auto" type="button" data-toggle="collapse" data-target="#inner-box2" aria-expanded="false" aria-controls="inner-box2"><span class="fas fa-plus"></span></button> </div>
                            <div id="inner-box2" class="collapse mt-2 mr-1">
                                <div class="my-1"> <label class="tick">Spring <input type="checkbox" checked="checked"> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Summer <input type="checkbox"> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Autumn <input type="checkbox" checked> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Winter <input type="checkbox"> <span class="check"></span> </label> </div>
                                <div class="my-1"> <label class="tick">Rainy <input type="checkbox"> <span class="check"></span> </label> </div>
                            </div>
                        </div>
                        <div class="box border-bottom">
                            <div class="box-label text-uppercase d-flex align-items-center">price <button class="btn ml-auto" type="button" data-toggle="collapse" data-target="#price" aria-expanded="false" aria-controls="price"><span class="fas fa-plus"></span></button> </div>
                            <div class="collapse" id="price">
                                <div class="middle">
                                    <div class="multi-range-slider"> <input type="range" id="input-left" min="0" max="100" value="10"> <input type="range" id="input-right" min="0" max="100" value="50">
                                        <div class="slider">
                                            <div class="track"></div>
                                            <div class="range"></div>
                                            <div class="thumb left"></div>
                                            <div class="thumb right"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center justify-content-between mt-2">
                                    <div> <span id="amount-left" class="font-weight-bold"></span> uah </div>
                                    <div> <span id="amount-right" class="font-weight-bold"></span> uah </div>
                                </div>
                            </div>
                        </div>
                        <div class="box">
                            <div class="box-label text-uppercase d-flex align-items-center">size <button class="btn ml-auto" type="button" data-toggle="collapse" data-target="#size" aria-expanded="false" aria-controls="size"><span class="fas fa-plus"></span></button> </div>
                            <div id="size" class="collapse">
                                <div class="btn-group d-flex align-items-center flex-wrap" data-toggle="buttons"> <label class="btn btn-success form-check-label"> <input class="form-check-input" type="checkbox"> 80 </label> <label class="btn btn-success form-check-label"> <input class="form-check-input" type="checkbox" checked> 92 </label> <label class="btn btn-success form-check-label"> <input class="form-check-input" type="checkbox" checked> 102 </label> <label class="btn btn-success form-check-label"> <input class="form-check-input" type="checkbox" checked> 104 </label> <label class="btn btn-success form-check-label"> <input class="form-check-input" type="checkbox" checked> 106 </label> <label class="btn btn-success form-check-label"> <input class="form-check-input" type="checkbox" checked> 108 </label> </div>
                            </div>
                        </div>
                    </div>
                    <div id="products">
                        <div class="row mx-0">
                            <c:forEach var="annuncio" items="${risultatiRicerca}">
                                <div class="col-lg-4 col-md-6">
                                    <div class="card d-flex flex-column align-items-center" >
                                        <a class=" stretched-link " href="/annuncio/${annuncio.idAnnuncio}" text-decoration-none>
                                            <div class="product-name">${annuncio.titolo}</div>
                                            <div class="card-img"> <img src="${annuncio.fotoCopertina}" alt=""> </div>
                                            <div class="card-body pt-5 ">
                                                <div class="text-muted text-center mt-auto">${annuncio.descrizione}</div>                                         
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