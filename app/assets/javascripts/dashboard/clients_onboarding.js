

Kindrdfood = Kindrdfood || {};

Kindrdfood.dashboard = Kindrdfood.dashboard || {};

Kindrdfood.dashboard.clients_onboarding = {

	init: function(){

		$(".clients-table.datatable").DataTable({
      "order": [[ 0, "desc" ]],
			initComplete: function () {
        this.api().columns().every( function () {
          var column = this;
          var select = $('<select><option value=""></option></select>')
            .appendTo( $(column.footer()).empty() )
            .on( 'change', function () {
              var val = $.fn.dataTable.util.escapeRegex(
                $(this).val()
              );
              column
	              .search( val ? '^'+val+'$' : '', true, false )
	              .draw();
            });

          column.data().unique().sort().each( function ( d, j ) {
            select.append( '<option value="'+d+'">'+d+'</option>' )
          });
      	});
      }
		})
	}
}	