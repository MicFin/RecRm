$(document).ready(function() {



    // hide all hidden options for recupe form
  $(".hidden-options").hide();
  // set click for buton to show hidden options when clicked
  $(".display-options-button").click(function(){
    if ($(this).next().is(":visible")){
      $(this).next().hide();     
    } else {
      $(this).next().show();
    };
  }); 


  // set select all buttons for recipe form
  $('.select-all-button').click(function(){
    if ($(this).val() !== "uncheck all"){
      $(this).next().children().children().each(function(i, e){
        $(e).children().prop('checked', true);
      }); 
      $(this).val('uncheck all');
      $(this).addClass('unselect-all-button');
    } else {
      $(this).next().children().children().each(function(i, e){
        $(e).children().prop('checked', false);
      });
      $(this).val('check all');
      $(this).removeClass('unselect-all-button');
    };     
  });


	// validate new recipe form with JS
  $("#new_recipe").validate({
    rules: {
      "recipe[name]":{
        required: true,
        minlength: 2
      }//,
      // "recipe[characteristic_ids][]": {
      //   required: true
      // }
    },
    messages: {
      "recipe[name]":{
        required: "Enter recipe name",
        minlength: "Must be at least 2 letters"
      }//,
      // "recipe[characteristic_ids][]": {
      //   required: "Please select at least 1 of each Prep Time, Cook Time, Difficulty, Relevant Courses, and Relevant Age Groups."
      // }
    },

  });

	// validate new ingredient form with JS: FAILING ****
  // i think it's due to the form being added in by JQuery so the validate listener isn't being attached (but I tried adding this to the new.js.erb and the create.js.erb so then it would be called after the form is inserted by JQuery and it didn't work either) or because form is remote true
  $("ingredients-recipe-form-validate").validate({
    rules: {
      "ingredients_recipe[amount]":{
        required: true,
        range: [0,100]
      },
      "ingredients_recipe[ingredients_attributes][name]":{
        required: true,
        minlength: 2
      },
    },
    messages: {
      "igredients_recipe[amount]":{
        required: "Enter an amount",
        range: "Must be between 0 and 100"
      },
      "ingredients_recipe[ingredients_attributes][name]":{
        required: "Enter an ingredient name",
        minlength: "Must be at least 2 letters"
      },
    }
  });
});