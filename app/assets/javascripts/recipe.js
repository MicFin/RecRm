// Gon is a Rails Gem that allows javascript to access rails global variables


// javascript class
var Recipe = {	

	// here is a method of the model 
    renderRecipe: function() { 
       
    	//using rails gon and rabl gems - Rable tutorial https://github.com/nesquena/rabl
    	var data = gon.recipe;
        var recipe = data.recipe;
 

    	var recipeHTML = "";
        var steps = recipe.recipe_steps

        //var badges = Recipe.getRecipeBadges();
        steps = Recipe.getRecipeSteps(steps);
        ingredients = Recipe.getIngredientsHTML(recipe.ingredients)
    

		recipeHTML += "<div class='recipeContainer'>"

            + "<div class='recipeContainerLeft'>"
                + "<div class='recipeTitle'>" + recipe.name + "</div>"
                + "<div class='recipeRDText'>RECOMMENDED <span class='recipeRDNormal'>by</span> <span class='recipeRDName'>Susan</span></div>"
                + "<div class='recipeDescriptionContainer'>" + recipe.description + "</div>"
                + "<div class='recipeIngredientsContainer'>"
                    + "<div class='recipeIngredientsTitle'>INGREDIENTS</div>"
                        + ingredients
                + "</div>"
                + "<div class='recipeStepContainer'>" + steps + "</div>" 
            + "</div>"

            + "<div class='recipeContainerRight'>"
            + "<div class='recipeImageContainer'>"
                + "<img class='recipeImage' src='" + recipe.image_url + "' \>"
                + "<div class='recipeLikeIcon'></div>"
            + "</div>"
            + "<div class='recipeCharacteristicsContainer'>"
                + "<div class='recipeCharacteristicsRow'>COOK TIME<br><span class='recipeCharacteristics'>" + recipe.cook_time.name + "</span></div>"
                + "<div class='recipeCharacteristicsRow'>PREP TIME<br><span class='recipeCharacteristics'>" + recipe.prep_time.name + "</span></div>"
                + "<div class='recipeCharacteristicsRow'>DIFFICULTY<br><span class='recipeCharacteristics'>" + recipe.difficulty.name + "</span></div>"
                + "<div class='recipeCharacteristicsRow'>BEST FOR<br><span class='recipeCharacteristics'>" + recipe.courses[0].name + "</span></div>"
                if (recipe.age_groups[0]){
                    recipeHTML += "<div class='recipeCharacteristicsRow'>AGE GROUPS<br><span class='recipeCharacteristics'>" + recipe.age_groups[0].name + "</span></div>"
                }
                if (recipe.scenarios[0]){
                    recipeHTML += "<div class='recipeCharacteristicsRow'>SCENERIOS<br><span class='recipeCharacteristics'>" + recipe.scenarios[0].name + "</span></div>"
                }
                if (recipe.holidays[0]){
                    recipeHTML += "<div class='recipeCharacteristicsRow'>HOLIDAYS<br><span class='recipeCharacteristics'>" + recipe.holidays[0].name + "</span></div>"
                }
                if (recipe.cultures[0]){
                    recipeHTML += "<div class='recipeCharacteristicsRow'>CULTURES<br><span class='recipeCharacteristics'>" + recipe.cultures[0].name + "</span></div>"
                }
                recipeHTML += "</div>"
            + "</div>"

      
        + "<div class='clear'></div></div>";



    	// display in html
    	$('#recipe').html(recipeHTML);

        $('.recipeLikeIcon').click(function() {  
            $(this).addClass('recipeLikeIconActive');
            //save data function
        });
    },


    getRecipeBadges: function(){

        var badgeHTML = "";

        badgeHTML += "<div class='recipeBadgesContainer'>"
            + "<div class='recipeDietitianBadge'></div>"
            + "<div class='recipeRecommededBadge'></div>"
        + "</div>";

        return badgeHTML
        
    },

    getRecipeSteps: function(data) {
        var l = data.length;
        var step = "";
        var stepsHTML = "";
         

         for (si = 0; si < l; si ++){

            step = data[si].recipe_step
            var ingredients = step.ingredients
            var ingredientsHTML = "";

            var ilength = ingredients.length;
            for (ii = 0; ii < ilength; ii ++){
                ingredientsHTML += "<div class='recipeStepIngredients'>" + ingredients[ii].ingredient.name + "</div>"
            }

            stepsHTML += "<div class='recipeStep'><span class='recipeNumber'>" + step.step_number + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>" + step.directions + ingredientsHTML + "<div class='clear'></div></div>";
            

         }
         return stepsHTML;
    },

    getIngredientsHTML: function(data) {
        var length = data.length;
        var ingredient = "";
        var ingredientsHTML = "";
         

         for (ii = 0; ii < length; ii ++){
            ingredient = data[ii].ingredient
            characteristic_list = ingredient.ingredients_recipe


           
          
            ingredientsHTML += characteristic_list.amount + "&nbsp;&nbsp; " + ingredient.name + " " + characteristic_list.amount_unit + "<br>";
             //+ " " +  characteristic_list.prep
            

         }
         return ingredientsHTML;
    },



    nextFunction: function(){
    	// someting awesome
    }

}




