<html>

<head>
    <link rel="stylesheet" href="/css/bannato.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function logout() {
            $.ajax({
                url: "rest/utenti/logout",
                type: "GET",
            })
        }
    </script>

</head>

<body onload="logout()" style="background-color:black;" >
    <center><img src="/immagini/logo/logo.png"></center>
    <center><h1>SEI STATO BANNATO</h1></center>
</body>

</html>
