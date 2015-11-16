
Kindrdfood = Kindrdfood || {};


Kindrdfood.formValidations = Kindrdfood.formValidations || {};

Kindrdfood.formValidations.growthEntries = {
  clientForm: function(){
    $("#new_growth_entry, form[id*='edit_growth_entry_']").validate({
      rules: {
        "growth_entry[height][feet]":{
          required: {
            depends: function () { 
              return ($("input[name='growth_entry[height][feet]']").val() != "" );
            }
          },
          range: [0, 10],
          number: true
        },
        "growth_entry[height][inches]":{
          required: {
            depends: function () { 
              if ( ( $("input[name='growth_entry[height][inches]']").val() != "" ) || ( $("input[name='growth_entry[height][feet]']").val() == "") ) {
                return true 
              } else {
                return false
              }
            }
          },
          range: [0, 120],
          number: true
        },
        "growth_entry[weight][pounds]":{
          required: {
            depends: function () { 
              return ( $("input[name='growth_entry[weight][pounds]']").val() != "" );
            }
          },
          range: [0, 1000],
          number: true
        },
        "growth_entry[weight][ounces]":{
          required: {
            depends: function () { 
              if ( ( $("input[name='growth_entry[weight][ounces]']").val() != "" ) || ( $("input[name='growth_entry[weight][pounds]']").val() == "") ) {
                return true 
              } else {
                false
              }
            }
          },
          range: [0, 16],
          number: true
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
        "growth_entry[height][feet]":{
          required: "Enter height",
          range: "Number between 0 and 10",
          number: "Number between 0 and 10"
        },
        "growth_entry[height][inches]":{
          required: "Enter height",
          range: "Number betweeen 0 and 120",
          number: "Number betweeen 0 and 120"
        },
        "growth_entry[weight][pounds]":{
          required: "Enter weight",
          range: "Number between 0 and 1000",
          number: "Number between 0 and 1000"
        },
        "growth_entry[weight][ounces]":{
          required: "Enter weight",
          range: "Number between 0 and 16",
          number: "Number between 0 and 16"
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