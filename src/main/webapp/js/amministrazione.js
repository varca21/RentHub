function banna(idUtente) {
    messaggio("Ban utente: ", "/rest/utenti/bannautente", idUtente, true);
}

function sbanna(idUtente) {
    messaggio("Sban utente: ", "/rest/utenti/bannautente", idUtente, false);
}

function messaggio(messaggio, link, utente, flag) {
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