<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <meta charset="utf-8">
            <title>${annuncio.titolo} - renthub.com</title>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
            <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="/css/paginaProdotto.css">
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
                                        <li data-target="#myCarousel-2" data-slide-to="0" class=""></li>
                                        <li data-target="#myCarousel-2" data-slide-to="1" class="active"></li>
                                        <li data-target="#myCarousel-2" data-slide-to="2" class=""></li>
                                    </ol>
                                    <div class="carousel-inner">
                                        <!-- Slide 1 -->
                                        <div class="item active">
                                            <img src="https://via.placeholder.com/700x400/FFB6C1/000000"
                                                class="img-responsive" alt="" />
                                        </div>
                                        <!-- Slide 2 -->
                                        <div class="item">
                                            <img src="https://via.placeholder.com/700x400/87CEFA/000000"
                                                class="img-responsive" alt="" />
                                        </div>
                                        <!-- Slide 3 -->
                                        <div class="item">
                                            <img src="https://via.placeholder.com/700x400/B0C4DE/000000"
                                                class="img-responsive" alt="" />
                                        </div>
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
                                <label><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        fill="currentColor" class="bi bi-tag" viewBox="0 0 16 16">
                                        <path
                                            d="M6 4.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-1 0a.5.5 0 1 0-1 0 .5.5 0 0 0 1 0z" />
                                        <path
                                            d="M2 1h4.586a1 1 0 0 1 .707.293l7 7a1 1 0 0 1 0 1.414l-4.586 4.586a1 1 0 0 1-1.414 0l-7-7A1 1 0 0 1 1 6.586V2a1 1 0 0 1 1-1zm0 5.586 7 7L13.586 9l-7-7H2v4.586z" />
                                    </svg>Affitto</label>
                            </c:if>
                            <c:if test="${!annuncio.affitto}">
                                <label><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
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
                                            <iframe src="https://www.google.com/maps/embed?pb=!" width=90% height=60% style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                                        </dl>
                                    </div>
                                    <div class="tab-pane fade" id="reviews">
                                        <br />
                                        <form method="post" class="well padding-bottom-10">
                                            <textarea rows="2" class="form-control"
                                                placeholder="Write a review"></textarea>
                                            <div class="margin-top-10">
                                                <button type="submit" class="btn btn-sm btn-primary pull-right">
                                                    Submit Review
                                                </button>
                                                <a href="javascript:void(0);" class="btn btn-link profile-link-btn"
                                                    rel="tooltip" data-placement="bottom" title=""
                                                    data-original-title="Add Location"><i
                                                        class="fa fa-location-arrow"></i></a>
                                                <a href="javascript:void(0);" class="btn btn-link profile-link-btn"
                                                    rel="tooltip" data-placement="bottom" title=""
                                                    data-original-title="Add Voice"><i class="fa fa-microphone"></i></a>
                                                <a href="javascript:void(0);" class="btn btn-link profile-link-btn"
                                                    rel="tooltip" data-placement="bottom" title=""
                                                    data-original-title="Add Photo"><i class="fa fa-camera"></i></a>
                                                <a href="javascript:void(0);" class="btn btn-link profile-link-btn"
                                                    rel="tooltip" data-placement="bottom" title=""
                                                    data-original-title="Add File"><i class="fa fa-file"></i></a>
                                            </div>
                                        </form>

                                        <div class="chat-body no-padding profile-message">
                                            <ul>
                                                <li class="message">
                                                    <img src="https://bootdey.com/img/Content/avatar/avatar1.png"
                                                        class="online" />
                                                    <span class="message-text">
                                                        <a href="javascript:void(0);" class="username">
                                                            Alisha Molly
                                                            <span class="badge">Purchase Verified</span>
                                                            <span class="pull-right">
                                                                <i class="fa fa-star fa-2x text-primary"></i>
                                                                <i class="fa fa-star fa-2x text-primary"></i>
                                                                <i class="fa fa-star fa-2x text-primary"></i>
                                                                <i class="fa fa-star fa-2x text-primary"></i>
                                                                <i class="fa fa-star fa-2x text-muted"></i>
                                                            </span>
                                                        </a>
                                                        Can't divide were divide fish forth fish to. Was can't form the,
                                                        living life grass darkness very image let unto fowl isn't in
                                                        blessed fill life yielding above all moved
                                                    </span>
                                                    <ul class="list-inline font-xs">
                                                        <li>
                                                            <a href="javascript:void(0);" class="text-info"><i
                                                                    class="fa fa-thumbs-up"></i> This was helpful
                                                                (22)</a>
                                                        </li>
                                                        <li class="pull-right">
                                                            <small class="text-muted pull-right ultra-light"> Posted 1
                                                                year ago </small>
                                                        </li>
                                                    </ul>
                                                </li>
                                                <li class="message">
                                                    <img src="https://bootdey.com/img/Content/avatar/avatar2.png"
                                                        class="online" />
                                                    <span class="message-text">
                                                        <a href="javascript:void(0);" class="username">
                                                            Aragon Zarko
                                                            <span class="badge">Purchase Verified</span>
                                                            <span class="pull-right">
                                                                <i class="fa fa-star fa-2x text-primary"></i>
                                                                <i class="fa fa-star fa-2x text-primary"></i>
                                                                <i class="fa fa-star fa-2x text-primary"></i>
                                                                <i class="fa fa-star fa-2x text-primary"></i>
                                                                <i class="fa fa-star fa-2x text-primary"></i>
                                                            </span>
                                                        </a>
                                                        Excellent product, love it!
                                                    </span>
                                                    <ul class="list-inline font-xs">
                                                        <li>
                                                            <a href="javascript:void(0);" class="text-info"><i
                                                                    class="fa fa-thumbs-up"></i> This was helpful
                                                                (22)</a>
                                                        </li>
                                                        <li class="pull-right">
                                                            <small class="text-muted pull-right ultra-light"> Posted 1
                                                                year ago </small>
                                                        </li>
                                                    </ul>
                                                </li>
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
                <!-- end product -->
            </div>



        </body>

        </html>