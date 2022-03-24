function modificaAnnuncio() {
    var titolo = document.querySelector("#venditaTitolo").value;
    var descrizione = document.querySelector("#venditaDescrizione").value;
    var metriQuadri = document.querySelector("#venditaMetriQuadri").value;
    var tipologia = document.querySelector("#selezioneTipologiaVendita").value;
    var citta = document.querySelector("#venditaCitta").value;
    var indirizzo = document.querySelector("#venditaIndirizzo").value;
    var cap = document.querySelector("#venditaCap").value;
    var id = document.querySelector("#idAnnuncio").value;
    var formData = new FormData();

    formData.append("titolo", titolo);
    formData.append("descrizione", descrizione);
    formData.append("metriQuadri", metriQuadri);
    formData.append("tipologia", tipologia);
    formData.append("citta", citta);
    formData.append("cap", cap);
    formData.append("indirizzo", indirizzo);

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