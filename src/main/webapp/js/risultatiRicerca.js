function cambioFiltri(){
    var url = new URL(document.location.href);
    var search_params = url.searchParams;

// the new url string

    filtroAffitto=$('#checkAffitto').is(":checked");
    filtroVendita=$('#checkVendita').is(":checked");
    
    if(filtroAffitto != filtroVendita){
        if(filtroAffitto)
            search_params.set('tipoVendita', 'affitto');
        if(filtroVendita)
            search_params.set('tipoVendita', 'vendita');
    }
    else
        search_params.delete('tipoVendita');

      
        document.location.href = url.toString();
    

    
}