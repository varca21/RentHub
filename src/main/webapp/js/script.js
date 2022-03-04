function registra() {
    var idUtente = document.querySelector("#userID").value;
    var nome = document.querySelector("#nome").value;
    var cognome = document.querySelector("#cognome").value;
    var email = document.querySelector("#emailreg").value;
    var password = document.querySelector("#password").value;
    var numTel = document.querySelector("#numTel").value;
    var dataNascita = document.querySelector("#dataNascita").value;
    $.ajax({
        url: "rest/utenti/registrazione",
        type: "POST",
        data: JSON.stringify(
            {
                "id": idUtente,
                "nome": nome,
                "cognome": cognome,
                "dataNascita": dataNascita,
                "numTel": numTel,
                "email": email,
                "password": password
            }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {//se la chiamata ajax restituisce codice 200
            window.location.replace("http://localhost:8080/");
        },
        error: function (jqxhr) {
            var errore = JSON.parse(jqxhr.responseText).message;
            alert(errore);
        },
    })
}
