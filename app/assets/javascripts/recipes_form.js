$(document).ready(function() {

  // // on page load recipes#new
  // // hide submit recipe button
  //  $("#recipe-form-section-submit").hide();
  // // hide all recipe form sections
  // $(".recipe-form-section").hide();
  //  // hide all recipe form nav buttons
  //  $(".recipe-form-nav-buttons").hide();   
  // // show first form section
  // $("#recipe-form-section-1").show();
  // $("#recipe-form-nav-buttons-1").show(); 
  // $("#next-recipe-form-buttons-1").click(function(){
  //   if ($("#recipe_name").val() != ""){
  //     if ($("#recipe-form-selector-1").children().first().val() != ""){
  //       if ($("#recipe-form-selector-2").children().first().val() != ""){
  //         if ($("#recipe-form-selector-3").children().first().val() != ""){
  //           // hide all recipe form sections
  //           $(".recipe-form-section").hide();
  //            // hide all recipe form nav buttons
  //            $(".recipe-form-nav-buttons").hide();
  //           // show second form section
  //           $("#recipe-form-section-2").show();
  //           $("#recipe-form-nav-buttons-2").show(); 
  //         };
  //       };
  //     };

  //   };
  // }); 

  // $("#next-recipe-form-buttons-2").click(function(){
  //   // hide all recipe form sections
  //   $(".recipe-form-section").hide();
  //    // hide all recipe form nav buttons
  //    $(".recipe-form-nav-buttons").hide();
  //   // show second form section
  //   $("#recipe-form-section-3").show();
  //   $("#recipe-form-nav-buttons-3").show(); 
  // }); 

  // $("#previous-recipe-form-buttons-2").click(function(){
  //   // hide all recipe form sections
  //   $(".recipe-form-section").hide();
  //    // hide all recipe form nav buttons
  //    $(".recipe-form-nav-buttons").hide();
  //   // show second form section
  //   $("#recipe-form-section-1").show();
  //   $("#recipe-form-nav-buttons-1").show(); 
  // }); 

  // $("#previous-recipe-form-buttons-3").click(function(){
  //   // hide all recipe form sections
  //   $(".recipe-form-section").hide();
  //    // hide all recipe form nav buttons
  //    $(".recipe-form-nav-buttons").hide();
  //   // show second form section
  //   $("#recipe-form-section-2").show();
  //   $("#recipe-form-nav-buttons-2").show(); 
  // // show submit recipe button
  //  $("#recipe-form-section-submit").show();
  // }); 

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