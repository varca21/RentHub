function registra() {
    var idUtente = document.querySelector("#userID").value;
    var nome = document.querySelector("#nome").value;
    var cognome = document.querySelector("#cognome").value;
    var email = document.querySelector("#emailreg").value;
    var password = document.querySelector("#password").value;
    var numTel = document.querySelector("#numTel").value;
    var dataNascita = document.querySelector("#dataNascita").value;
    cancellaValidazione(document.querySelector("#emailreg"), document.querySelector("#messaggioValidazioneEmailreg"));
    cancellaValidazione(document.querySelector("#userID"), document.querySelector("#messaggioValidazioneUserId"));
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
            if (errore == "ID presente") {
                invalidaCampo(document.querySelector("#userID"), document.querySelector("#messaggioValidazioneUserID"), "Id gia presente");
            } else if (errore == "Email presente") {
                invalidaCampo(document.querySelector("#emailreg"), document.querySelector("#messaggioValidazioneEmailreg"), "Email gia presente");
            }
        },
    })
}

function aggiornaUtente() {
    var idUtente = document.querySelector("#userID").value;
    var nome = document.querySelector("#nome").value;
    var cognome = document.querySelector("#cognome").value;
    var email = document.querySelector("#emailreg").value;
    var numTel = document.querySelector("#numTel").value;
    var dataNascita = document.querySelector("#dataNascita").value;
    $.ajax({
        url: "rest/utenti/aggiornaUtente",
        type: "POST",
        data: JSON.stringify(
            {
                "id": idUtente,
                "nome": nome,
                "cognome": cognome,
                "dataNascita": dataNascita,
                "numTel": numTel,
                "email": email
            }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {//se la chiamata ajax restituisce codice 200
            logout();
        },
        error: function (jqxhr) {
            var errore = JSON.parse(jqxhr.responseText).message;
            console.log(errore);
        },
    })
}


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
            window.location.replace("http://localhost:8080/");
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
        url: "rest/utenti/logout",
        type: "GET",
        success: function (response) {
            window.location.replace("http://localhost:8080/");
        },
        error: function (jqxhr) {
            var errore = JSON.parse(jqxhr.responseText).message;
            alert(errore);
        },
    })
}

function impostazioniAccount() {
    $('#modalRegistrazione').modal('show');
    $.ajax({
        url: "rest/utenti/utenteCorrente",
        type: "GET",
        success: function (data) {//se la chiamata ajax restituisce codice 200
            $('h4.titoloRegistrazione').text('Modifica account');
            $("#tastoRegistrati").text('Salva modifiche');
            document.querySelector("#userID").value = data.idUtente;
            document.querySelector("#userID").disabled = true;
            document.querySelector("#nome").value = data.nome;
            document.querySelector("#cognome").value = data.cognome;
            document.querySelector("#emailreg").value = data.email;
            document.querySelector("#emailreg").disabled = true;
            $('#password').hide();
            $('#labelPassword').hide();
            document.querySelector("#numTel").value = data.numTelefono;
            document.querySelector("#dataNascita").value = data.dataNascita;
            $('#tastoRegistrati').remove('onclick');
            $('#tastoRegistrati').attr('onclick', 'aggiornaUtente()');
        },
        error: function (jqxhr) {
            var errore = JSON.parse(jqxhr.responseText).message;
            alert(errore);
        },
    })
}


function invalidaCampo(campo, label, messaggio) {
    campo.classList.remove("is-valid");
    campo.classList.add("is-invalid");
    label.text = messaggio;
    label.show;
}

function cancellaValidazione(campo, label) {
    var listaClassi = campo.classList;
    campo.classList.remove("is-valid");
    campo.classList.remove("is-invalid");
    label.hide;
}

function validaCampo(campo, label) {
    campo.classList.remove("is-invalid");
    campo.classList.add("is-valid");
    label.hide;
}


