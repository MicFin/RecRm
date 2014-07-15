// Gon is a Rails Gem that allows javascript to access rails global variables


// javascript class
var Recipe = {	

	// here is a method of the model 
    renderRecipe: function() { 
       
    	//using rails gon and rabl gems - Rable tutorial https://github.com/nesquena/rabl
    	var data = gon.recipe;
        console.log(data)
        var recipe = data.recipe;
 

    	var recipeHTML = "";
        var steps = recipe.recipe_steps

        var badges = Recipe.getRecipeBadges();
        steps = Recipe.getRecipeSteps(steps);
        //ingredients = Home.getIngredientsHTML(recipe.ingredients)
    

		recipeHTML += "<div class='recipeContainer'>"
            + "<div class='recipeTitle'>" + recipe.name + badges + "</div>"
            + "<div class='recipeImageContainer'>"
                + "<img class='recipeImage' src='" + recipe.image_url + "' \>"
                + "<div class='recipeLikeIcon'></div>"
            + "</div>"
            + "<div class='recipeDescriptionContainer'>" + recipe.description + "</div>"
            + "<div class='recipeCharacteristicsContainer'>"
                + "<div class='recipeCharacteristicsRow'>Cook Time<br><span class='recipeCharacteristics'>" + recipe.cook_time.name + "</span></div>"
                + "<div class='recipeCharacteristicsRow'>Prep Time<br><span class='recipeCharacteristics'>" + recipe.prep_time.name + "</span></div>"
                + "<div class='recipeCharacteristicsRow'>Difficulty<br><span class='recipeCharacteristics'>" + recipe.difficulty.name + "</span></div>"
                + "<div class='recipeCharacteristicsRow'>Best for<br><span class='recipeCharacteristics'>" + recipe.courses[0].name + "</span></div>"
                if (recipe.age_groups[0]){
                    recipeHTML += "<div class='recipeCharacteristicsRow'>Age Groups<br><span class='recipeCharacteristics'>" + recipe.age_groups[0].name + "</span></div>"
                }
                if (recipe.scenarios[0]){
                    recipeHTML += "<div class='recipeCharacteristicsRow'>Scenerios<br><span class='recipeCharacteristics'>" + recipe.scenarios[0].name + "</span></div>"
                }
                if (recipe.holidays[0]){
                    recipeHTML += "<div class='recipeCharacteristicsRow'>Scenerios<br><span class='recipeCharacteristics'>" + recipe.holidays[0].name + "</span></div>"
                }
                if (recipe.cultures[0]){
                    recipeHTML += "<div class='recipeCharacteristicsRow'>Scenerios<br><span class='recipeCharacteristics'>" + recipe.cultures[0].name + "</span></div>"
                }
            recipeHTML += "</div>"
            + "<div class='recipeStepsContainer'>"
                + "<div class='letsCook'>Let's Cook</div>" 
                + steps 
            + "</div>"
       // + "<div class='recipeThumbIngredients'>" + ingredients + "</div>" 
        + '</div>';
            


    	// display in html
    	$('#recipe').html("<div class='recipesThumbsHome'>" + recipeHTML + "</div>");

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
                ingredientsHTML += "&nbsp;&nbsp;&nbsp;" + ingredients[ii].ingredient.name
               

            }

            stepsHTML += "<div class='recipeStep'><div class='recipeNumber'>" + step.step_number + "</div>" + step.directions + "<div class='recipeStepIngredients'>" + ingredientsHTML + "</div></div>";
            

         }
         return stepsHTML;
    },

    // getIngredientsHTML: function(data){
    //     var length = data.length
    //     var ingredient = "";

    //     var ingredientsHTML = "";

    //     for (ii = 0; ii < length; ii ++){
    //         ingredient = data[ii].ingredient

    //         ingredientsHTML += "&nbsp;&nbsp;&nbsp;" + ingredient.name;

    //     }
    //     return ingredientsHTML; 
    // },

    // getCharacteristicsHTML: function(data){
    //     var length = data.length
    //     var characteristic = "";

    //     var characteristicsHTML = "";

    //     for (ci = 0; ci < length; ci ++){
    //         characteristic = data[ci].characteristic

    //         characteristicsHTML +=  characteristic.category + ": " + characteristic.name  + "<br>";
    //         if (ci > 2) {
    //             break
    //         }

    //     }
    //     return characteristicsHTML; 
    // },

    nextFunction: function(){
    	// someting awesome
    }

}




