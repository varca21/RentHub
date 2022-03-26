function modificaAnnuncio() {
    var titolo = document.querySelector("#venditaTitolo").value;
    var descrizione = document.querySelector("#venditaDescrizione").value;
    var metriQuadri = document.querySelector("#venditaMetriQuadri").value;
    var tipologia = document.querySelector("#selezioneTipologiaVendita").value;
    var citta = document.querySelector("#venditaCitta").value;
    var indirizzo = document.querySelector("#venditaIndirizzo").value;
    var cap = document.querySelector("#venditaCap").value;
    var prezzo = document.querySelector("#venditaPrezzo").value;
    var prezzoScontato = document.querySelector("#venditaPrezzoScontato").value;
    var id = document.querySelector("#idAnnuncio").value;
    var formData = new FormData();

    formData.append("titolo", titolo);
    formData.append("descrizione", descrizione);
    formData.append("metriQuadri", metriQuadri);
    formData.append("tipologia", tipologia);
    formData.append("citta", citta);
    formData.append("cap", cap);
    formData.append("indirizzo", indirizzo);
    formData.append("prezzo", prezzo);
    formData.append("prezzoScontato", prezzoScontato);

    $.ajax({
        url: "/rest/annunci/modifica/" + id,
        method: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function (response) {//se la chiamata ajax restituisce codice 200
            window.location.reload();
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            var errore = JSON.parse(jqxhr.responseText).message;
            console.log(errore);
        },
    })
}

function aggiungiRecensione(){
    var descrizione = document.querySelector("#recensione").value;
    var id = document.querySelector("#idAnnuncio").value;
    var utente = document.querySelector("#idUtente").value;
    $.ajax({
        url: "/rest/recensioni/nuova",
        method: "GET",
        data:{
            "idUtente":utente,
            "idAnnuncio":id,
            "recensione":descrizione
        },
        success: function (response) {//se la chiamata ajax restituisce codice 200
            alert("recensione inserita");
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            alert("errore");
            var errore = JSON.parse(jqxhr.responseText).message;
            alert(errore);
            console.log(errore);
           
        },
    })

}

function visualizzaInfoUtente(idUtente){
    $.ajax({
        url: "/rest/utenti/ricerca",
        method: "GET",
        data:{
            "id":idUtente,       
        },
        success: function (response) {//se la chiamata ajax restituisce codice 200
            document.querySelector("#nome").value=response.nome;
            document.querySelector("#cognome").value=response.cognome;
            if(response.numTelefono!="null")
                document.querySelector("#numTelefono").value=response.numTelefono;
            document.querySelector("#email").value=response.email;
            document.querySelector("#idU").value=response.idUtente;
            $('#modalInfoUtente').modal('show');
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            alert("errore");
            var errore = JSON.parse(jqxhr.responseText).message;
            alert(errore);
            console.log(errore);
           
        },
    })
}

function cancellaAnnuncio(idAnnuncio){
    $.ajax({
        url: "/rest/annunci/cancella",
        method: "GET",
        data:{
            "id":idAnnuncio,       
        },
        success: function (response) {//se la chiamata ajax restituisce codice 200
            window.location.replace("/");
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            var errore = JSON.parse(jqxhr.responseText).message;
            alert(errore);
            console.log(errore);
           
        },
    })
}


function contattaVenditore(destinatario,idAnnuncio){
    alert(destinatario);
    $.ajax({
        url: "/rest/utenti/contattautente",
        method: "GET",
        data:{
            "destinatario":destinatario,  
            "idAnnuncio":idAnnuncio,
            "messaggio":document.querySelector("#messaggio").value
        },
        success: function (response) {//se la chiamata ajax restituisce codice 200
            window.location.replace("/");
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            var errore = JSON.parse(jqxhr.responseText).message;
            console.log(errore);
           
        },
    })
}