function apriModalAccesso() {
    $("#Accedi").modal("show");
}

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
            document.location.href = "/";
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




function inserisciAnnuncio() {
    var titolo = document.querySelector("#venditaTitolo").value;
    var descrizione = document.querySelector("#venditaDescrizione").value;
    var prezzo = document.querySelector("#venditaPrezzo").value;
    var metriQuadri = document.querySelector("#venditaMetriQuadri").value;
    var tipologia = document.querySelector("#selezioneTipologiaVendita").value;
    var citta = document.querySelector("#venditaCitta").value;
    var indirizzo = document.querySelector("#venditaIndirizzo").value;
    var cap = document.querySelector("#venditaCap").value;
    var affitto = document.querySelector('input[name="radioAffitta"]:checked').value;
    var formData = new FormData();
    $.each($("input[type='file']")[0].files, function(i, file) {
        formData.append('foto', file);
    });
    formData.append("titolo",titolo);
    formData.append("descrizione",descrizione);
    formData.append("prezzo",prezzo);
    formData.append("metriQuadri",metriQuadri);
    formData.append("tipologia",tipologia);
    formData.append("citta",citta);
    formData.append("indirizzo",indirizzo);
    formData.append("cap",cap);
    formData.append("affitto",affitto);
    $.ajax({
        url: "rest/annunci/nuovo",
        method: "POST",
        data:formData,
        contentType: false,
        processData: false,
        success: function (response) {//se la chiamata ajax restituisce codice 200
            document.location.href = "/";
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            var errore = JSON.parse(jqxhr.responseText).message;
            console.log(errore);
        },
    })
}

function ricerca(){
    var url = new URL(document.location+"cercaAnnuncio");
    var search_params = url.searchParams;

    var titolo = document.querySelector("#cercaTitolo").value;
    var citta = document.querySelector("#cercaCitta").value;
    var indirizzo = document.querySelector("#cercaIndirizzo").value;
    var tipologiaImmobile = document.querySelector("#cercaTipologiaImmobile").value;
    var tipologiaVendita=document.querySelector("#cercaTipologiaVendita").value;


    if(titolo.length>0)
        search_params.set('testo',titolo);

    if(citta.length>0)
        search_params.set('citta',citta);

    if(indirizzo.length>0)
        search_params.set('indirizzo',indirizzo);


    
    if(tipologiaImmobile!="niente")
        search_params.set('tipologia',tipologiaImmobile);
    if(tipologiaVendita!="niente")
        search_params.set('tipoVendita',tipologiaVendita);
        
        document.location.href = url.toString();

}