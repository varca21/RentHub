function cambioFiltri() {
    
    var tipologia = $("#selezioneTipologiaVendita option:selected").text();
    filtroAffitto = $('#checkAffitto').is(":checked");
    filtroVendita = $('#checkVendita').is(":checked");
    
    
    var tipologiavendita;
    if (filtroAffitto != filtroVendita) {
        if (filtroAffitto)           
        tipologiavendita='affitto';
        if (filtroVendita)
        tipologiavendita='vendita';
    }
    
    var ordinamento = $("#selezioneFiltri").val();

    $('#prodotti').empty();
    $.ajax({
        url: "rest/annunci/cercaannuncio",
        type: "GET",
        data:{
            "tipologia":tipologia,
            "tipovendita":tipologiavendita
        },
        success: function (response) {
            var annunci = response;

            if(ordinamento=="prezzodown"){
                annunci.sort(ordinamentoPrezziDown);
                $("#selezioneFiltri option[value=prezzodown]").attr('value', 'prezzoup');
                $("#selezioneFiltri").find(":selected").html('Prezzo &#8593');
            }

            if(ordinamento=="metridown"){
                annunci.sort(ordinamentoMetriDown);
                $("#selezioneFiltri option[value=metridown]").attr('value', 'metriup');
                $("#selezioneFiltri").find(":selected").html('Metri  &#8593');
            }
        
            if(ordinamento=="prezzoup"){
                annunci.sort(ordinamentoPrezziUp);
                $("#selezioneFiltri option[value=prezzoup]").attr('value', 'prezzodown');
                $("#selezioneFiltri").find(":selected").html('Prezzo &#8595');
            }

            if(ordinamento=="metriup"){
                annunci.sort(ordinamentoMetriUp);
                $("#selezioneFiltri option[value=metriup]").attr('value', 'metridown');
                $("#selezioneFiltri").find(":selected").html('Metri &#8595');

            }
            
            annunci.forEach(annuncio => {
                let card = document.createElement('div');
                card.className = 'col-lg-4 col-md-6 p-2';

                let cardstyle = document.createElement('div');
                cardstyle.className = 'card d-flex flex-column align-items-center';

                let link = document.createElement('a');
                link.className = 'stretched-link';
                link.href = '/annuncio/' +annuncio.idAnnuncio;
                link.textDecoration = 'text-decoration-none';
                

                let tipologia = document.createElement('div');
                tipologia.className= 'text-muted text-center mt-auto';
                tipologia.innerText=annuncio.tipologia;

                let immagine = document.createElement('div');
                immagine.className= 'card-img';
                immagine.innerHTML="<img src='"+annuncio.fotoCopertina+"' alt=''>";

                let cardBody = document.createElement('div');
                cardBody.className = 'card-body pt-5 ';

                let titolo = document.createElement('div');
                titolo.className= 'product-name';
                titolo.innerText=annuncio.titolo;
                
                let indirizzo = document.createElement('div');
                indirizzo.className='text-muted  mt-auto';
                indirizzo.innerText=annuncio.posizione.indirizzo+","+annuncio.posizione.citta;

                let prezzo= document.createElement('div');
                prezzo.className='d-flex align-items-center price';
             
                  
                if(annuncio.prezzoScontato!=0){
                    let prezzoVero=document.createElement('div');
                    prezzoVero.className='del mr-2';
                    prezzoVero.innerHTML="<span class='text-dark'>"+annuncio.prezzo+"&#8364;</span>"
                    prezzo.appendChild(prezzoVero);

                    let prezzoScontato=document.createElement('div');
                    prezzoScontato.className='font-weight-bold';
                    prezzoScontato.innerHTML=annuncio.prezzoScontato+" &#8364"
                    prezzo.appendChild(prezzoScontato);
                }else{
                    let prezzoVero=document.createElement('div');
                    prezzoVero.innerHTML="<span class='text-dark'>"+annuncio.prezzo+"&#8364;</span>"
                    prezzo.appendChild(prezzoVero);
                }
                if(annuncio.affitto){
                    let almese=document.createElement('small')
                    almese.innerHTML="&nbsp al mese";
                    prezzo.appendChild(almese);
                }

                cardBody.appendChild(titolo);
                cardBody.appendChild(indirizzo);
                cardBody.appendChild(prezzo);
                link.appendChild(tipologia);
                link.appendChild(immagine);
                link.appendChild(cardBody);
                cardstyle.appendChild(link);
                card.appendChild(cardstyle);
                $('#prodotti').append(card);
            });
            $("#selezioneFiltri").prop('selectedIndex', 0);
        },
        error: function (jqxhr) {
            var errore = JSON.Parse(jqxhr.responseText).message;
            alert(errore);
        },
    })
}

window.onload=function(){
    var url = new URL(document.location.href);
    var search_params = url.searchParams;
    if(search_params.get('tipoVendita')=="affitto"){
        $("#checkAffitto").prop('checked', true);
        $("#checkVendita").prop('checked', false);
    }
    if(search_params.get('tipoVendita')=="vendita"){
        $("#checkVendita").prop('checked', true);
        $("#checkAffitto").prop('checked', false);
    }
    if(search_params.get('tipologia')!=null){
        var tipologia=search_params.get('tipologia');
        $('#selezioneTipologiaVendita option[value='+tipologia).attr('selected','selected');
    }

    
}

function ordinamentoMetriUp( a, b ) {
    if ( a.metriQuadri < b.metriQuadri ){
      return -1;
    }
    if ( a.metriQuadri >= b.metriQuadri ){
      return 1;
    }
    return 0;
}

function ordinamentoMetriDown( a, b ) {
    if ( a.metriQuadri > b.metriQuadri ){
      return -1;
    }
    if ( a.metriQuadri <= b.metriQuadri ){
      return 1;
    }
    return 0;
}

function ordinamentoPrezziUp( a, b ) {
    var prezzoa;
    var prezzob;
    a.prezzoScontato!=0 ? prezzoa=a.prezzoScontato : prezzoa=a.prezzo;
    b.prezzoScontato!=0 ? prezzob=b.prezzoScontato : prezzob=b.prezzo;

    if (prezzoa<prezzob){
      return -1;
    }
    if (prezzoa>=prezzob){
      return 1;
    }
    return 0;
}

function ordinamentoPrezziDown( a, b ) {
    var prezzoa;
    var prezzob;
    a.prezzoScontato!=0 ? prezzoa=a.prezzoScontato : prezzoa=a.prezzo;
    b.prezzoScontato!=0 ? prezzob=b.prezzoScontato : prezzob=b.prezzo;

    if (prezzoa>prezzob){
      return -1;
    }
    if (prezzoa<=prezzob){
      return 1;
    }
    return 0;
}