
$(document).ready(function() {
		$("#sortable").sortable({
		  placeholder: "ui-state-highlight",
		  connectWith: ".column",
		  start: function(e, ui){
		      ui.placeholder.height(ui.item.height())
		  },
		  axis: 'y',
		  update: function() {
		    return $.post($(this).data('update-url'), $(this).sortable("serialize"))
		  }
		});
		$( "#sortable" ).disableSelection();
});