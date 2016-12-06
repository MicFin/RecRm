

Kindrdfood = Kindrdfood || {};

Kindrdfood.appointments = Kindrdfood.appointments || {};

Kindrdfood.appointments.edit = {

	init: function(){

		// initiate datetimepicker
		Kindrdfood.dateTimePickers.dateTimePicker.init();

				// 
		$('#appointment_appointment_host_id').on("change", function(event){

			var familyId = $(this).find(":selected").data("family-id");

			$("#appointment_patient_focus_id option").each(function() {  

				if ( $(this).data("family-id") != familyId ) { 
					$(this).addClass("hidden");
				} else { 
					$(this).removeClass("hidden");
				}
			})
			$("#appointment_patient_focus_id option").not(".hidden").first().prop('selected', true);
		});


		$(".previous-appointments.datatable, .upcoming-appointments.datatable").DataTable({ 
			responsive: true,
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