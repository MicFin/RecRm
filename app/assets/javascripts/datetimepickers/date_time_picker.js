

Kindrdfood = Kindrdfood || {};


Kindrdfood.dateTimePickers = Kindrdfood.dateTimePickers || {};

Kindrdfood.dateTimePickers.dateTimePicker = {
  init: function(){
  	$("#datetimepicker, .datetimepicker").datetimepicker({ 
  		sideBySide: true, 
  		allowInputToggle: true,
  		format: "ddd MMM D, YYYY h:mm A" 
  	});

	},
	dateOnlyInit: function(){
		$('#datepicker').datetimepicker({
      format: 'DD/MM/YYYY',
      allowInputToggle: true
    });
	}
}