<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


    <html>

    <head>
      <link rel="stylesheet" href="/css/amministrazione.css">
      <script src="/js/amministrazione.js"></script>

      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
      <title> AMMINISTRAZIONE </title>
    </head>

    <body>
      <table class="table table-dark table-hover table-bordered">
        <thead>
          <tr>
            <th>ID Utente</th>
            <th>e-mail</th>
            <th>Bannato</th>
            <th>Amministratore</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="utente" items="${utenti}">
            <tr>
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
                  <button>RIMUOVI AMMINISTRATORE</button>
                </c:if>
                <c:if test="${utente.ruolo!='AMMINISTRATORE'}">
                  <button>PROMUOVI AMMINISTRATORE</button>
                </c:if>
              </td>

            </tr>
          </c:forEach>
        </tbody>
      </table>

      <div class="modal fade" id="FinestraDialogoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Conferma</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              ...
            </div>
            <div class="modal-footer">
              <button type="button" id="tastoConferma" class="btn btn-primary">Conferma</button>
              <button type="button" class="btn btn-danger" data-dismiss="modal">Annulla</button>
            </div>
          </div>
        </div>
      </div>


    </body>

    </html>