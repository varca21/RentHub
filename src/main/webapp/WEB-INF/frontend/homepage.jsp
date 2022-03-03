<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">

    <div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#Accedi" >Login</button>
            </li>
        </ul>
    </div>
</nav>

<!-- The Modal -->
<div class="modal" id="Accedi">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">ACCEDI</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <form action="/action_page.php">
                    <div class="form-group">
                        <label for="email">Email o UserID:</label>
                        <input type="email" class="form-control" placeholder="Inserisci email o UserID" id="email">
                    </div>
                    <div class="form-group">
                        <label for="pwd">Password:</label>
                        <input type="password" class="form-control" placeholder="Inserisci password" id="pwd">
                    </div>

                    <center>
                        <button type="submit" class="btn btn-primary">Accedi</button>
                    </center>
                </form>
            </div>

                <center>
                    <h6 class="modal-title">Non sei ancora registrato? Registrati!</h6>
                </center>


        </div>
    </div>
</div>

</body>
</html>
