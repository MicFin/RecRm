
Kindrdfood = Kindrdfood || {};


Kindrdfood.formValidations = Kindrdfood.formValidations || {};

Kindrdfood.formValidations.growthEntries = {
  clientForm: function(){
    $("#new_growth_entry, form[id*='edit_growth_entry_']").validate({
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
  },
  dietitianForm: function(){
    // multiple edits forms are on the same page so have to validate them all
    $('form[id*="edit_growth_entry_"]').each( function(){
      var form = $(this);
      form.validate({

        rules: {
          "growth_entry[height_percentile]":{
            required: true,
          },
          "growth_entry[height_z_score]":{
            required: true,
          },
          "growth_entry[weight_percentile]":{
            required: true
          },
          "growth_entry[weight_z_score]":{
            required: true
          },
          "growth_entry[bmi_percentile]":{
            required: true
          },
          "growth_entry[bmi_z_score]":{
            required: true
          },
          "growth_entry[energy_requirement]":{
            required: true
          },
          "growth_entry[protein_requirement]":{
            required: true
          },
          "growth_entry[fluids_requirement]":{
            required: true
          }
        },
        messages: {
          "growth_entry[height_percentile]":{
            required: "Enter height %"
          },
          "growth_entry[height_z_score]":{
            required: "Enter height z score"
          },
          "growth_entry[weight_percentile]":{
            required: "Enter weight %"
          },
          "growth_entry[weight_z_score]":{
            required: "Enter weigth z score"
          },
          "growth_entry[bmi_percentile]":{
            required: "Enter BMI %"
          },
          "growth_entry[bmi_z_score]":{
            required: "Enter BMI z score"
          },
          "growth_entry[energy_requirement]":{
            required: "Enter energy"
          },
          "growth_entry[protein_requirement]":{
            required: "Enter protein"
          },
          "growth_entry[fluids_requirement]":{
            required: "Enter fluids"
          }
        }
      })
    })
  }
}