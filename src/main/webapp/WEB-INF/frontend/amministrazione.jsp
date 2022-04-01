<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


    <html>

    <head>


      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
      <title> AMMINISTRAZIONE </title>
      <script type="text/javascript" src="/js/jquery.tablesorter.js"></script>
      <script src="/js/amministrazione.js"></script>
      <link rel="stylesheet" href="/css/amministrazione.css">
    </head>
    
    <body>
  
      <div class="bg-dark rounded d-flex align-items-center justify-content-between" id="header">
        <a href="/"><img src="/immagini/logo/logo.png" height=60 > </a>  
        <button class="btn btn-hide text-uppercase" type="button"  onclick="logout()"> 
            <span class="fas fa-angle-left" id="filter-angle"></span> 
            <span id="btn-txt">Logout</span> 
        </button>
                             
    </div>
      <section class="ftco-section">
        <div class="container">
          <div class="row justify-content-center">
            
            <div class="col-md-6 text-center mb-5">

              <h2 class="heading-section">Amministrazione</h2>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <div class="table-wrap">
                <table class="table tablesorter" id="tabellaAmministrazione">
                  <thead class="thead-dark">
                    <tr>
                      <th>ID Utente</th>
                      <th>e-mail</th>
                      <th>Bannato</th>
                      <th>Amministratore</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="utente" items="${utenti}">
                      <tr class="alert" role="alert">
                        <td>${utente.idUtente}</td>
                        <td>${utente.email}</td>
                        <td>
                          <c:if test="${utente.bannato}">
                            <button onclick="sbanna('${utente.idUtente}')">SBANNA</button>
                          </c:if>
                          <c:if test="${!utente.bannato}">
                            <button onclick="banna('${utente.idUtente}')">BANNA</button>
                          </c:if>
                        </td>
                        <td>
                          <c:if test="${utente.ruolo=='AMMINISTRATORE'}">
                            <button onclick="togliAmministratore('${utente.idUtente}')">RIMUOVI AMMINISTRATORE</button>
                          </c:if>
                          <c:if test="${utente.ruolo!='AMMINISTRATORE'}">
                            <button onclick="rendiAmministratore('${utente.idUtente}')">PROMUOVI AMMINISTRATORE</button>
                          </c:if>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </section>
      <div class="modal fade" id="FinestraDialogoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Sei sicuro di voler continuare?</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              ...
            </div>
            <div class="modal-footer">
              <button type="button" id="tastoConferma" class="tastoConferma">Conferma</button>
              <button type="button" class="tastoAnnulla" data-dismiss="modal">Annulla</button>
            </div>
          </div>
        </div>
      </div>


    </body>

    </html>