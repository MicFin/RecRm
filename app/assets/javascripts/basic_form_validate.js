var BasicForm = {
  validate: function(){
    $( "#recipe-name" ).keyup(function() {
    	$("#recipe-title").replaceWith("<h2 id='recipe-title'>"+$("#recipe-name").val() + "</h2>");
    		if ($("#recipe-name").val() === ""){
    		  $("#recipe-title").replaceWith("<h2 id='recipe-title' class='light-gray-font'>YOUR RECIPE TITLE</h2>");
    	  };
    });
    // validate new recipe form with JS
    $("#new_recipe").validate({
      rules: {
        "recipe[name]":{
          required: true,
          minlength: 2
        }
      },
      messages: {
        "recipe[name]":{
          required: "Enter recipe name",
          minlength: "Must be at least 2 letters"
        }

      },

    });
  },
  setSliders: function(){
  /// CAN  CUT THIS INTO 1/3 AMOUNT OF CODE
    var preptime = $( "#recipe_prep_time" );
    var preptimeslider = $( "<div class='slider'></div>" ).insertAfter( preptime ).slider({
      min: 1,
      max: $("#recipe_prep_time option").length,
      range: "min",
      value: preptime[ 0 ].selectedIndex + 1,
      slide: function( event, ui ) {
        preptime[ 0 ].selectedIndex = ui.value - 1;
        // changes preview when bar changed
        $("#preptime-preview").replaceWith("<h4 id='preptime-preview'>"+$( "#recipe_prep_time option:selected" ).text() + "</h4>");
      }
    });
    // makes select box change the slider
    $( "#recipe_prep_time" ).change(function() {
      preptimeslider.slider( "value", this.selectedIndex + 1 );
      // changes preview when select changed
      $("#preptime-preview").replaceWith("<h4 id='preptime-preview'>"+$( "#recipe_prep_time option:selected" ).text() + "</h4>");
    });

    var cooktime = $("#recipe_cook_time");
    var cooktimeslider = $( "<div class='slider'></div>" ).insertAfter( cooktime ).slider({
      min: 1,
      max: $("#recipe_cook_time option").length,
      range: "min",
      value: cooktime[ 0 ].selectedIndex + 1,
      slide: function( event, ui ) {
        cooktime[ 0 ].selectedIndex = ui.value - 1;
       // changes preview when bar changed
        $("#cooktime-preview").replaceWith("<h4 id='cooktime-preview'>"+$( "#recipe_cook_time option:selected" ).text() + "</h4>");
      }
    });
    // makes select box change the slider
    $( "#recipe_cook_time" ).change(function() {
      cooktimeslider.slider( "value", this.selectedIndex + 1 );          
      // changes preview when select changed
      $("#cooktime-preview").replaceWith("<h4 id='cooktime-preview'>"+$( "#recipe_cook_time option:selected" ).text() + "</h4>");
    });

    var difficulty = $( "#recipe_difficulty" );
    var difficultyslider = $( "<div class='slider'></div>" ).insertAfter( difficulty ).slider({
      min: 1,
      max: $("#recipe_difficulty option").length,
      range: "min",
      value: difficulty[ 0 ].selectedIndex + 1,
      slide: function( event, ui ) {
        difficulty[ 0 ].selectedIndex = ui.value - 1;
        // changes preview when bar changed
        $("#difficulty-preview").replaceWith("<h4 id='difficulty-preview'>"+$( "#recipe_difficulty option:selected" ).text() + "</h4>");
      }
    });
    // makes select box change the slider
    $( "#recipe_difficulty" ).change(function() {
      difficultyslider.slider( "value", this.selectedIndex + 1 );
      // changes preview when select changed
      $("#difficulty-preview").replaceWith("<h4 id='difficulty-preview'>"+$( "#recipe_difficulty option:selected" ).text() + "</h4>");
    });

    var serves = $( "#recipe_serving_size" );
    var servesslider = $( "<div class='slider'></div>" ).insertAfter( serves ).slider({
      min: 1,
      max: $("#recipe_serving_size option").length,
      range: "min",
      value: serves[ 0 ].selectedIndex + 1,
      slide: function( event, ui ) {
        serves[ 0 ].selectedIndex = ui.value - 1;
      // changes preview when select changed
        $("#serving-size-preview").replaceWith("<h4 id='serving-size-preview'>"+$( "#recipe_serving_size option:selected" ).text() + "</h4>");
      }
    });
    // makes select box change the slider
    $( "#recipe_serving_size" ).change(function() {
      servesslider.slider( "value", this.selectedIndex + 1 );
      // changes preview when select changed
      $("#serving-size-preview").replaceWith("<h4 id='serving-size-preview'>"+$( "#recipe_serving_size option:selected" ).text() + "</h4>");
    });
  },
  setReviewSliders: function(){
  /// CAN  CUT THIS INTO 1/3 AMOUNT OF CODE
    var preptime = $( "#recipe_prep_time" );
    var preptimeslider = $( "<div class='slider'></div>" ).insertAfter( preptime ).slider({
      min: 1,
      max: $("#recipe_prep_time option").length,
      range: "min",
      value: preptime[ 0 ].selectedIndex + 1,
      slide: function( event, ui ) {
        preptime[ 0 ].selectedIndex = ui.value - 1;
      }
    });
    // makes select box change the slider
    $( "#recipe_prep_time" ).change(function() {
      preptimeslider.slider( "value", this.selectedIndex + 1 );
    });

    var cooktime = $("#recipe_cook_time");
    var cooktimeslider = $( "<div class='slider'></div>" ).insertAfter( cooktime ).slider({
      min: 1,
      max: $("#recipe_cook_time option").length,
      range: "min",
      value: cooktime[ 0 ].selectedIndex + 1,
      slide: function( event, ui ) {
        cooktime[ 0 ].selectedIndex = ui.value - 1;
      }
    });
    // makes select box change the slider
    $( "#recipe_cook_time" ).change(function() {
      cooktimeslider.slider( "value", this.selectedIndex + 1 );          

    });

    var difficulty = $( "#recipe_difficulty" );
    var difficultyslider = $( "<div class='slider'></div>" ).insertAfter( difficulty ).slider({
      min: 1,
      max: $("#recipe_difficulty option").length,
      range: "min",
      value: difficulty[ 0 ].selectedIndex + 1,
      slide: function( event, ui ) {
        difficulty[ 0 ].selectedIndex = ui.value - 1;
      }
    });
    // makes select box change the slider
    $( "#recipe_difficulty" ).change(function() {
      difficultyslider.slider( "value", this.selectedIndex + 1 );
    });

    var serves = $( "#recipe_serving_size" );
    var servesslider = $( "<div class='slider'></div>" ).insertAfter( serves ).slider({
      min: 1,
      max: $("#recipe_serving_size option").length,
      range: "min",
      value: serves[ 0 ].selectedIndex + 1,
      slide: function( event, ui ) {
        serves[ 0 ].selectedIndex = ui.value - 1;
      }
    });
    // makes select box change the slider
    $( "#recipe_serving_size" ).change(function() {
      servesslider.slider( "value", this.selectedIndex + 1 );
    });
  },
  validateReview: function(){
    // validate new recipe form with JS
    $("#new_recipe").validate({
      rules: {
        "recipe[name]":{
          required: true,
          minlength: 2
        }
      },
      messages: {
        "recipe[name]":{
          required: "Enter recipe name",
          minlength: "Must be at least 2 letters"
        }
      },
    });
  }
}