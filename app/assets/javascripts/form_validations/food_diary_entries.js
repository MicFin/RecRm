
Kindrdfood = Kindrdfood || {};


Kindrdfood.formValidations = Kindrdfood.formValidations || {};

Kindrdfood.formValidations.foodDiaryEntries = {
  init: function(){
    Kindrdfood.dateTimePickers.dateTimePicker.init();
    $("#new_food_diary_entry, form[id*='edit_food_diary_entry_']").validate({
      rules: {
        "food_diary_entry[consumed_at]":{
          required: true
        },
        "food_diary_entry[location]":{
          required: true
        },
        "food_diary_entry[food_item]":{
          required: true
        }
      },
      messages: {
        "food_diary_entry[consumed_at]":{
          required: "Enter date and time"
        },

        "food_diary_entry[location]":{
          required: "Enter location"
        },
        "food_diary_entry[food_item]":{
          required: "Enter meal or item"
        }
      }
    })
  }
}