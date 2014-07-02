// Gon is a Rails Gem that allows javascript to access rails global variables


// javascript class
var Home = {	

	// here is a method of the model 
    renderRecipeList: function() { 

    	//user rails gon gem
    	var data = gon.recipe_list;
    	var length = data.length;
    	var recipeListHTML = "";

    	//loop through data and add html
    	for (array = 0; array < length; array++){
    		recipeListHTML += "<div>" + data[array].name + "</div>";
    		
    	}

    	// display in html
    	$('#recipeList').html(recipeListHTML);
    }, 

    nextFunction: function(){
    	// someting awesome
    }

}




