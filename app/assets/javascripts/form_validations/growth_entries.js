
Kindrdfood = Kindrdfood || {};


Kindrdfood.formValidations = Kindrdfood.formValidations || {};

Kindrdfood.formValidations.growthEntries = {
  init: function(){
    $("#new_growth_entry").validate({
      rules: {
        "growth_entry[height_in_inches]":{
          required: true,
        },
        "growth_entry[weight_in_ounces]":{
          required: true,
        },
        "growth_entry[measured_at(1i)]":{
          required: true
        },
        "growth_entry[measured_at(2i)]":{
          required: true
        },
        "growth_entry[measured_at(3i)]":{
          required: true
        }
      },
      messages: {
        "growth_entry[height_in_inches]":{
          required: "Please enter a height."
        },
        "growth_entry[weight_in_ounces]":{
          required: "Please enter a height."
        },
        "growth_entry[measured_at(1i)]":{
          required: "Enter year"
        },
        "growth_entry[measured_at(2i)]":{
          required: "Enter month"
        },
        "growth_entry[measured_at(3i)]":{
          required: "Enter day"
        }
      }
    })
  }
}