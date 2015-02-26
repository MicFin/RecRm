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
    },
    contentQuotaValidations: function(){
      $("#new_content_quota").validate({
        rules: {
          "content_quota[recipes]":{
            required: true,
            range: [0, 50]
          },
          "content_quota[quality_reviews]":{
            required: true,
            range: [0, 50]
          },
          "content_quota[review_conflicts]":{
            required: true,
            range: [0, 50]
          }
        },
        messages: {
          "content_quota[recipes]":{
            required: "Please enter a number between 0-50",
            range: "Please enter a number between 0-50"
          },
          "content_quota[quality_reviews]":{
            required: "Please enter a number between 0-50",
            range: "Please enter a number between 0-50"
          },
          "content_quota[review_conflicts]":{
            required: "Please enter a number between 0-50",
            range: "Please enter a number between 0-50"
          }
        },
      });
    },
    user_intro: function(){
      $("#new-user-name-form #edit_user").validate({
        rules: {
          "user[first_name]":{
            required: true,
            minlength: 2
          },
          "user[last_name]":{
            required: true,
            minlength: 2
          },
          "client_last_name":{
            required: true,
            minlength: 2
          },
          "client_first_name":{
            required: true,
            minlength: 2
          },
        },
        messages: {
          "user[first_name]":{
            required: "Enter first name",
            minlength: "Must be at least 2 letter"
          },
          "user[last_name]":{
            required: "Enter last name",
            minlength: "Must be at least 2 letter"
          },
          "client_first_name":{
            required: "Enter first name",
            minlength: "Must be at least 2 letter"
          },
          "client_last_name":{
            required: "Enter last name",
            minlength: "Must be at least 2 letter"
          },
        }
      });
    },
    // checks if inputs have been motified and warns if users leaves browser
    dirty_form_catcher: function(){
      var _isDirty = false;
      $(":input").change(function(){
        _isDirty = true;
      });  
      // creates a function to override the close window prompt
      function closeEditorWarning(event){
        if (_isDirty === true) {
          return 'It looks like you have been editing something -- if you leave before submitting your changes will be lost.'
        };
      };
      // on before unload chßeck if forms are dirty.
      window.onbeforeunload = closeEditorWarning; 
      // disable onbeforeunlaod for submits
      $('form').submit(function () {
        window.onbeforeunload = null;
      });
    },
    //
    nutrition_form: function(){

      $("#new-user-options form").validate({
        rules: {
          "user[first_name]":{
            required: true,
            minlength: 2
          },
          "user[last_name]":{
            required: true,
            minlength: 2
          },
          "user[height][feet]":{
            required: {
              depends: function () { 
                return ($("input[name='user[height][feet]']").val() != "" );
              }
            },
            range: [0, 10],
            number: true
          },
          "user[height][inches]":{
            required: {
              depends: function () { 
                return ( $("input[name='user[height][inches]']").val() != "" );
              }
            },
            range: [0, 120],
            number: true
          },
          "user[weight][pounds]":{
            required: {
              depends: function () { 
                return ( $("input[name='user[weight][pounds]']").val() != "" );
              }
            },
            range: [0, 1000],
            number: true
          },
          "user[weight][ounces]":{
            required: {
              depends: function () { 
                return ( $("input[name='user[weight][ounces]']").val() != "" );
              }
            },
            range: [0, 16],
            number: true
          },
        },
        messages: {
          "user[first_name]":{
            required: "Enter first name",
            minlength: "Must be at least 2 letter"
          },
          "user[last_name]":{
            required: "Enter last name",
            minlength: "Must be at least 2 letter"
          },
          "user[height][feet]":{
            required: "Enter height",
            range: "Number between 1 and 10",
            number: "Number between 1 and 10"
          },
          "user[height][inches]":{
            required: "Enter height",
            range: "Number betweeen 1 and 120",
            number: "Number betweeen 1 and 120"
          },
          "user[weight][pounds]":{
            required: "Enter weight",
            range: "Number between 1 and 1000",
            number: "Number between 1 and 1000"
          },
          "user[weight][ounces]":{
            required: "Enter weight",
            range: "Number between 1 and 16",
            number: "Number between 1 and 16"
          },
        },
        errorPlacement: function (error, element) {
            $(element).tooltip({ title: $(error).text()});  
        },
        success: function (label, element) {
            $(element).tooltip("destroy"); 
        }
      });
    },
   // checks if inputs have been motified and warns if users leaves browser
    nutrition_form_appt_focus: function(){
      $("#new-user-options.appt-focus .edit_user.simple_form").first().validate({
        rules: {
          "user[first_name]":{
            required: true,
            minlength: 2
          },
          "user[last_name]":{
            required: true,
            minlength: 2
          },
          "user[date_of_birth(1i)]":{
            required: true
          },
          "user[date_of_birth(2i)]":{
            required: true
          },
          "user[date_of_birth(3i)]":{
            required: true
          },
          "user[height][feet]":{
            required: function(element) {
              return (!$("input[name='user[height][inches]']").hasClass('valid') || $("input[name='user[height][feet]']").val() != "" || ( $("input[name='user[height][inches]']").val() === "" && $("input[name='user[height][feet]']").val() === "" ));
            },
            range: {
              param: [1, 10],
              depends: function(element) {
                  // if inches is not filled out then require range
                if (!$("input[name='user[height][inches]']").hasClass('valid')){
                  return true;
                  // else if inches is filled out and feet is not blank or 0 then require range
                } else if ( $("input[name='user[height][feet]']").val() != "" && $("input[name='user[height][feet]']").val() != "0" ) {
                  return true;
                  // else inches is filled out and feet is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[height][inches]":{
            required: function(element) {
              return (!$("input[name='user[height][feet]']").hasClass('valid') || $("input[name='user[height][inches]']").val() != "" || ( $("input[name='user[height][inches]']").val() === "" && $("input[name='user[height][feet]']").val() === "" ));
            },
            range: {
              param: [1, 120],
              depends: function(element) {
                  // if feet is not filled out then require range
                if (!$("input[name='user[height][feet]']").hasClass('valid')){
                  return true;
                  // else if feet is filled out and inches is not blank or 0 then require range
                } else if ( $("input[name='user[height][inches]']").val() != "" && $("input[name='user[height][inches]']").val() != "0" ) {
                  return true;
                  // else feet is filled out and inches is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[weight][pounds]":{
            required: function(element) {
              return (!$("input[name='user[weight][ounces]']").hasClass('valid') || $("input[name='user[weight][pounds]']").val() != ""|| ( $("input[name='user[weight][pounds]']").val() === "" && $("input[name='user[weight][inches]']").val() === "" ) );
            },
            range: {
              param: [1, 1000],
              depends: function(element) {
                  // if ounces is not filled out then require range
                if (!$("input[name='user[weight][ounces]']").hasClass('valid')){
                  return true;
                  // else if ounces is filled out and pounds is not blank or 0 then require range
                } else if ( $("input[name='user[weight][pounds]']").val() != "" && $("input[name='user[weight][pounds]']").val() != "0" ) {
                  return true;
                  // else ounces is filled out and pounds is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[weight][ounces]":{
            required: function(element) {
              return (!$("input[name='user[weight][pounds]']").hasClass('valid') || $("input[name='user[weight][ounces]']").val() != "" || ( $("input[name='user[weight][pounds]']").val() === "" && $("input[name='user[weight][ounces]']").val() === "" ));
            },
            range: {
              param: [1, 16],
              depends: function(element) {
                  // if pounds is not filled out then require range
                if (!$("input[name='user[weight][pounds]']").hasClass('valid')){
                  return true;
                  // else if pounds is filled out and ounces is not blank or 0 then require range
                } else if ( $("input[name='user[weight][ounces]']").val() != "" && $("input[name='user[weight][ounces]']").val() != "0" ) {
                  return true;
                  // else pounds is filled out and ounces is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[sex]":{
            required: true
          },
          "user[family_role]":{
            required: true,
            minlength: 2
          }
        },
        messages: {
          "user[first_name]":{
            required: "Enter first name",
            minlength: 2
          },
          "user[last_name]":{
            required: "Enter last name",
            minlength: 2
          },
          "user[date_of_birth(1i)]":{
            required: "Enter year"
          },
          "user[date_of_birth(2i)]":{
            required: "Enter month"
          },
          "user[date_of_birth(3i)]":{
            required: "Enter day"
          },
          "user[height][feet]":{
            required: "Enter height",
            range: "Number between 1 and 10",
            number: "Number between 1 and 10"
          },
          "user[height][inches]":{
            required: "Enter height",
            range: "Number betweeen 1 and 120",
            number: "Number betweeen 1 and 120"
          },
          "user[weight][pounds]":{
            required: "Enter weight",
            range: "Number between 1 and 1000",
            number: "Number between 1 and 1000"
          },
          "user[weight][ounces]":{
            required: "Enter weight",
            range: "Number between 1 and 16",
            number: "Number between 1 and 16"
          },
          "user[sex]":{
            required: "Select gender"
          },
          "user[family_role]":{
            required: "How are you related?",
            minlength: "How are you related?"
          },
        },
        errorPlacement: function (error, element) {
            $(element).tooltip({ title: $(error).text(), placement: "top"});  
        },
        success: function (label, element) {
            $(element).tooltip("destroy"); 
        }
      })
    }
  } //Formvalidation   