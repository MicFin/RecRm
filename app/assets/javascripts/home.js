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

            //ingredients = Home.getIngredientsHTML(recipe.ingredients)
            //characteristics = Home.getCharacteristicsHTML(recipe.characteristics)
            ingredients = recipe.ingredients.length
            steps = recipe.recipe_steps.length

    		recipeListHTML += "<div class='recipeThumbLeft' onclick='location.href=\"recipe/" + recipe.id + "\"'>"
                + "<div class='recipeThumbBackground'></div>"
                + "<div class='recipeThumbImageContainer'>"
                    + "<img class='recipeThumbImage' src='" + recipe.image_url + "' \>"
                + "</div>"
                + "<div class='recipeThumbCover'>"
                    + "<div class='recipeThumbTitle' onclick='location.href=\"recipe/" + recipe.id + "\"'>" + recipe.name + "</div>"
                    + "<div class='recipeThumbSteps'><b>" + steps + "</b> steps &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>" + ingredients + "</b> ingredients</div>"
                + "</div>"

            
            + "</div>"
            
    	}
        recipeListHTML += "<div class='clear'></div>"

    	// display in html
    	$('#recipeList').html("<div class='recipesThumbsHome'>" + recipeListHTML + "</div>");

        $('.recipeThumbLeft').hover(function() { 
            $(this).find(".recipeThumbBackground").toggleClass("recipeThumbBackgroundActive"); 
            $(this).find(".recipeThumbCover").toggleClass("recipeThumbCoverActive"); 

        });
    }, 

    getIngredientsHTML: function(data){
        var length = data.length
        var ingredient = "";

        var ingredientsHTML = "";

        for (ii = 0; ii < length; ii ++){
            ingredient = data[ii].ingredient

            ingredientsHTML += "&nbsp;&nbsp;&nbsp;&nbsp;" + ingredient.name;

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




