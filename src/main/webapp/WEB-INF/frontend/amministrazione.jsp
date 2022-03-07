<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


    <html>

    <head>
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
                  <button>SBANNA</button>
                </c:if>
                <c:if test="${!utente.bannato}">
                  <button>BANNA</button>
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
    </body>

    </html>