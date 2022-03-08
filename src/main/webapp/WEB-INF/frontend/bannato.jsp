<html>

<head>
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

<body onload="logout()">

</body>

</html>
SEI STATO BANNATO!