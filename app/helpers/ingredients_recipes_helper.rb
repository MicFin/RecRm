module IngredientsRecipesHelper

  def get_ingredient_prep_options!
    @prep_options = ["chopped", "steamed", "minced", "julianed", "quartered", "cored", "sliced", "cubed", "diced", "chiffonade", "shredded", "shifted", "seeded", "soaked", "rinsed", "drained", "mashed", "peeled", "halved", "whipped", "pressed", "grated", "zested", "pounded", "pulled", "salted", "stewed", "smashed", "ground", "washed", "beaten", "melted"].sort
  end

end