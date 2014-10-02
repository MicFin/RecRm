
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
		$( ".delete-step-group" ).on("click", function(e){
		  e.preventDefault();
		  if ($(this).parent().parent().next().children().children().length <= 0){
		    $(this).parent().parent().remove();
		  }else{
		    alert("Oops! You should not delete a group that has steps in it. Please rearrange your steps or change the name of the group.")
		  };
		});
});