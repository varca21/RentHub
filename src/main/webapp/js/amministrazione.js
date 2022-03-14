function banna(idUtente) {
    conferma("Ban utente: ", "/rest/utenti/bannautente", idUtente, true);
}

function sbanna(idUtente) {
    conferma("Sban utente: ", "/rest/utenti/bannautente", idUtente, false);
}

function rendiAmministratore(idUtente){
    conferma("Rendi amministratore: ","/rest/utenti/promuoviamministratore",idUtente,true);
}

function togliAmministratore(idUtente){
    conferma("Rimuovi amministratore: ","/rest/utenti/promuoviamministratore",idUtente,false);
}

function conferma(messaggio, link, utente, flag) {
    $('#FinestraDialogoModal').modal();
    $('#FinestraDialogoModal').modal().find('.modal-body').text(messaggio + " " + utente);
    $('#tastoConferma').remove('onclick');
    document.getElementById("tastoConferma").onclick=function(){
        $.ajax({
            url: link,
            type: "GET",
            data: {
                id:utente,
                flag:flag
            },
            success: function (response) {
                window.location.replace("/amministrazione");
            },
            error: function (jqxhr) {
                var errore = JSON.parse(jqxhr.responseText).message;
                console.log(errore);
            },
        })
    };

}

function logout() {
    $.ajax({
        url: "rest/utenti/logout",
        type: "GET",
        success: function (response) {
            window.location.replace("/");
        },
        error: function (jqxhr) {
            var errore = JSON.parse(jqxhr.responseText).message;
            alert(errore);
        },
    })
}

$(function() {
    $("#tabellaAmministrazione").tablesorter();
  });



