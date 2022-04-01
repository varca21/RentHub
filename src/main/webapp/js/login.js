function login() {
    var idUtente = document.querySelector("#idlogin").value;
    var password = document.querySelector("#pwd").value;
    cancellaValidazione(document.querySelector("#pwd"), document.querySelector("#messaggioValidazionePwd"));
    cancellaValidazione(document.querySelector("#idlogin"), document.querySelector("#messaggioValidazioneId"));
    $.ajax({
        url: "/rest/utenti/login",
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
                invalidaCampo(document.querySelector("#idlogin"), document.querySelector("#messaggioValidazioneId"), errore);
            }
            if (errore == "Password errata") {
                validaCampo(document.querySelector("#idlogin"), document.querySelector("#messaggioValidazioneId"));

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

function cancellaValidazione(campo, label) {
    var listaClassi = campo.classList;
    campo.classList.remove("is-valid");
    campo.classList.remove("is-invalid");
    label.hide;
}

function invalidaCampo(campo, label, messaggio) {
    campo.classList.remove("is-valid");
    campo.classList.add("is-invalid");
    label.text = messaggio;
    label.show;
}



function validaCampo(campo, label) {
    campo.classList.remove("is-invalid");
    campo.classList.add("is-valid");
    label.hide;
}