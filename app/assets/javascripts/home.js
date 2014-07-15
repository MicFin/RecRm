// Gon is a Rails Gem that allows javascript to access rails global variables


// javascript class
var Home = {	

	// here is a method of the model 
    renderRecipeList: function() { 
       
    	//using rails gon and rabl gems - Rable tutorial https://github.com/nesquena/rabl
    	var data = gon.filtered_recipes;
        // are we loading?
        console.log(data)
    	var length = data.length;
    	var recipeListHTML = "";
        var recipe = "";
        var ingredients = "";
        var steps = "";

    	//loop through data and add html
    	for (ri = 0; ri < length; ri++){
            recipe = data[ri].recipe

            ingredients = Home.getIngredientsHTML(recipe.ingredients)
            //characteristics = Home.getCharacteristicsHTML(recipe.characteristics)
            steps = recipe.recipe_steps.length

    		recipeListHTML += "<div class='recipeThumbLeft'>"
            + "<div class='recipeThumbTitle' onclick='location.href=\"recipe/" + recipe.id + "\"'>" + recipe.name + "</div>"
            + "<div class='recipeThumbImageContainer' onclick='location.href=\"recipe/" + recipe.id + "\"'>"
                + "<img class='recipeThumbImage' src='" + recipe.image_url + "' \>"
                + "<div class='recipeThumbCover'>"
                    + "<div class='recipeThumbSteps'>" + steps + " steps</div>"
                    //+ "<div class='recipeThumbSteps'>" + characteristics + "</div>"
                + "</div>"
                + "<div class='recipeThumbDietitianImage'></div>"
            + "</div>"
            + "<div class='recipeThumbIngredients'>" + ingredients + "</div>" 
            + '</div>'
            
    	}

    	// display in html
    	$('#recipeList').html("<div class='recipesThumbsHome'>" + recipeListHTML + "</div>");
    }, 

    getIngredientsHTML: function(data){
        var length = data.length
        var ingredient = "";

        var ingredientsHTML = "";

        for (ii = 0; ii < length; ii ++){
            ingredient = data[ii].ingredient

            ingredientsHTML += "&nbsp;&nbsp;&nbsp;" + ingredient.name;

        }
        return ingredientsHTML; 
    },

    getCharacteristicsHTML: function(data){
        var length = data.length
        var characteristic = "";

        var characteristicsHTML = "";

        for (ci = 0; ci < length; ci ++){
            characteristic = data[ci].characteristic

            characteristicsHTML +=  characteristic.category + ": " + characteristic.name  + "<br>";
            if (ci > 2) {
                break
            }

        }
        return characteristicsHTML; 
    },

    nextFunction: function(){
    	// someting awesome
    }

}




