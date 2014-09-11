$(document).ready(function() {
  alert("alert");


  $(".unit-autofill").autocomplete({
      source: $('.unit-autofill').data('autocomplete-source')
  });
  // validate form
  $("#new_ingredients_recipe").validate({
    rules: {
      "ingredients_recipe[amount]":{
        required: true,
      },
      "ingredients_recipe[amount_unit]":{
        required: true,
        minlength: 2
      },
      "ingredients_recipe[display_name]":{
        required: true,
        minlength: 2
      },
      "ingredients_recipe[ingredient_attributes][name]":{
        required: true,
        minlength: 2
      },
    },
    messages: {
      "ingredients_recipe[amount]":{
        required: "Enter amount",
        range: "Between 0 and 100"
      },
      "ingredients_recipe[amount_unit]":{
        required: "Enter unit",
        minlength: "At least 2 letters"
      },
      "ingredients_recipe[display_name]":{
      	required: "Enter name",
      	minlength: "At least 2 letters"
      },
      "ingredients_recipe[ingredient_attributes][name]":{
      	required: "Enter name",
      	minlength: "At least 2 letters"
      },
    }
  })
})
