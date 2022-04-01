function login() {
    var idUtente = document.querySelector("#email").value;
    var password = document.querySelector("#pwd").value;
    cancellaValidazione(document.querySelector("#pwd"), document.querySelector("#messaggioValidazionePwd"));
    cancellaValidazione(document.querySelector("#email"), document.querySelector("#messaggioValidazioneId"));
    $.ajax({
        url: "rest/utenti/login",
        type: "POST",
        data: JSON.stringify(
            {
                "id": idUtente,
                "password": password
            }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            location.reload();
        },
        error: function (jqxhr) {
            var errore = JSON.parse(jqxhr.responseText).message;
            if (errore == "Account non esistente") {
                invalidaCampo(document.querySelector("#email"), document.querySelector("#messaggioValidazioneId"), errore);
            }
            if (errore == "Password errata") {
                validaCampo(document.querySelector("#email"), document.querySelector("#messaggioValidazioneId"));
                invalidaCampo(document.querySelector("#pwd"), document.querySelector("#messaggioValidazionePwd"), errore);
            }
        },
    })
}

function logout() {
    $.ajax({
        url: "/rest/utenti/logout",
        type: "GET",
        success: function (response) {
            location.reload();
        },
        error: function (jqxhr) {
            var errore = JSON.parse(jqxhr.responseText).message;
            alert(errore);
        },
    })
}