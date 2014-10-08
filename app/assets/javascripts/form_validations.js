  var FormValidation = {
    // new user sign in form validations
    signInValidations: function(){
      $("#new_user").validate({
        rules: {
          "user[email]":{
            email: true,
            required: true,
          }
        },
        messages: {
          "user[email]":{
            email: "Enter valid email",
            required: "Enter valid email"
          }
        },
      });
    },
    // auto fills form with data-autocomplete-source attribute value
    unitAutofill:  function() {
      $(".unit-autofill").autocomplete({
        source: $('.unit-autofill').data('autocomplete-source')
      });
    }, //unitAutofill

    ingredientAutofill:  function() {
      $(".ingredient-autofill").autocomplete({
        source: $('.ingredient-autofill').data('autocomplete-source')
      });
    }, //ingrdientAutofill

    displayNameAutofill:  function() {
      $(".display-name-autofill").autocomplete({
        source: $('.display-name-autofill').data('autocomplete-source')
      });
    }, //ingrdientdisplaynameAutofill

    // validates ingredients_recipe form fields
    ingredientValidations: function(){
      $("#new_ingredients_recipe").validate({
        rules: {
          "ingredients_recipe[amount]":{
            required: true,
            regex: /^(\d+(?:(?: \d+)*\/\d+)?)$/
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
            range: "Between 0 and 100",
            regex: "Format: 2 1/4"
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
      });
        // set unselect button for new form
      $(".unselect-ingredient-options").on("click", function(){
        var radio_container = $(this).next();
        radio_container.find("input").prop('checked', false);
      });
    }, // ingredientValidations
    // same as new ingredient but uses class not id to attach to form
    editIngredientValidations: function(){
      $(".edit_ingredients_recipe").validate({
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
            range: "Between 0 and 100",
            regex: "1 1/2 or 1.5 only"
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
      });
      // set unselect button for edit form
      $(".unselect-ingredient-options").on("click", function(){
        var radio_container = $(this).next();
        radio_container.find("input").prop('checked', false);
      });
    }, // editingredientValidations
    stepsValidations: function(){
      $("#new_recipe_step").validate({
        rules: {
          "recipe_step[directions]":{
            required: true,
            minlength: 5
          }
        },
        messages: {
          "recipe_step[directions]":{
            required: "Enter recipe step",
            minlength: "Must be at least 5 characters"
          }
        },
      });
      // set select all button for ingredients in step
      $(".select-all-ingredients-button").on("click", function(){
        $(this).next().find("input").prop('checked', true)
      });
    }, // stepsValidations
    // same as new step except uses class to attach to form
    editStepsValidations: function(){
      $(".edit_recipe_step").validate({
        rules: {
          "recipe_step[directions]":{
            required: true,
            minlength: 5
          }
        },
        messages: {
          "recipe_step[directions]":{
            required: "Enter recipe step",
            minlength: "Must be at least 5 characters"
          }
        },
      });
      // set select all button for ingredients in step
      $(".select-all-ingredients-button").on("click", function(){
        $(this).next().find("input").prop('checked', true)
      });
    }, // stepsValidations
    ingredientAllergensValidations: function(){
      $( ".allergen-autofill" ).autocomplete({
        source: $('.allergen-autofill').data('autocomplete-source')
      });
      // when add allergen is clicked add html form
      $("#add-allergen").on("click", function(){
        var html = "<li><label class='checkbox'><input class='check_boxes optional' name='ingredient[extra_allergens][]' type='checkbox' value='"+$("#ingredient_allergen_name").val()+"' checked>"+$("#ingredient_allergen_name").val()+"</label></li>";
        $("#added-allergens ul").append(html);
      }); 
    }, // ingredientAllergensValidations
    sortableIngredientList: function(){
      $("#ingredient-sortable").sortable({
        placeholder: "ui-state-highlight",
        connectWith: ".column",
        start: function(e, ui){
            ui.placeholder.height(ui.item.height());
            ui.placeholder.width(ui.item.width())
        },
        axis: 'y',
        update: function() {
          return $.post($(this).data('update-url'), $(this).sortable("serialize"))
        }
      });
      $( "#ingredient-sortable" ).disableSelection();
    }, // sortableIngrdientList
    ingredientAllergensReview: function(){
      $(".add-allergen").on("click", function(){
        var allergen = $(this).parent().prev().find("input").val();
        var html = "<li><label class='checkbox'><input class='check_boxes optional' name='review_conflict[first_suggestion][allergens][]' type='checkbox' value='"+allergen+"' checked>"+allergen+"</label></li>";
        $(this).parent().next().find("ul").append(html);
      }); 
      $( ".allergen-autofill" ).autocomplete({
        source: $('.allergen-autofill').data('autocomplete-source')
      });
    }
  } //Formvalidation   