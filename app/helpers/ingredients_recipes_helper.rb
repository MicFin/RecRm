module IngredientsRecipesHelper

  # def get_ingredient_prep_options!
  #   @prep_options = ["chopped", "steamed", "minced", "julianed", "quartered", "cored", "sliced", "cubed", "diced", "chiffonade", "shredded", "shifted", "seeded", "soaked", "rinsed", "drained", "mashed", "peeled", "halved", "whipped", "pressed", "grated", "zested", "pounded", "pulled", "salted", "stewed", "smashed", "ground", "washed", "beaten", "melted"].sort
  # end

  def get_units!
    @units = ["cup", "teaspoon", "tablespoon", "ounce", "pound", "fluid ounce", "gill", "pint", "quart", "gallon", "milliliter", "liter", "deciliter", "milligram", "gram", "kilogram", "pinch", "handful", "dash", "to taste", "bushel", "drop", "piece", "whole", "half", "slice", "cloves", "each", "as needed", "sprig", "dash", "once around the pot", "spear", "stalk", "splash", "dollop", "loaf", "square", "pat", "sheet", "wedge", "ear", "section"].sort
  end

end