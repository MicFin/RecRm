
$(document).ready(function() {
		$(".steps-sortable").sortable({
		  placeholder: "ui-state-highlight",
		  connectWith: ".steps-sortable",
		  start: function(e, ui){
		      ui.placeholder.height(ui.item.height())
		  },
		  axis: 'y',
		  update: function() {
		    return $.post($(this).data('update-url'), $(this).sortable("serialize"))
		  }
		});
		$( ".steps-sortable" ).disableSelection();
});