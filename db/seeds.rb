# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# # Create admin user
# 1. admin user

# # Create admin deititian
# 1. admin dietitian

# # Create deititians
# 1. dietitian with no upcoming or previous appointments
# 2. dietitian with upcoming appointment, not prepped
# 2. dietitian with upcoming appointment, prepped
# 3. dietitian with upcoming appointment, prepped, within an hour
# 4. dietitian with previous appointments

# # Create physicians
# 1. physician with no referrals
# 2. physician with multiple referrals

# # Create survey groups and questions

# # Create patient groups with triggers and patient groups without triggers

# # Create users (and necessary family members, appointments, surveys, growth charts, food diaries, and rooms)
# Create users without referrals
# 1. user at registration stage 1
# 2. user at registration stage 2
# 3. user at registration stage 3
# 4. user at registration stage 4
# 5. user at registration stage 5
# 6. user first appointment, not prepped
# 7. user first appointment, prepped
# 8. user first appointment, prepped, within an hour
# 9. user with previous appointment
# 10. user with previous appointment, follow up at registration stage 1
# 11. user with previous appointment, follow up at registration stage 2
# 12. user with previous appointment, follow up at registration stage 3
# 13. user with previous appointment, follow up at registration stage 4
# 14. user with previous appointment, follow up at registration stage 5
# 15. user with previous appointment, follow up scheduled, 30 minute
# 16. user with previous appointment, follow up scheduled, 60 minute
# 17. user with previous appointment, follow up scheduled, not paid for
# 18. user with previous appointment, package
# Create users with physician referrals
# 19. user with physician invitation, not yet accepted
# 20. user with physician invitation, accepted, at registration stage 1
# 21. user with physician invitation, accepted, at registration stage 2
# 22. user with physician invitation, accepted, at registration stage 3
# 23. user with physician invitation, accepted, at registration stage 4
# 24. user with physician invitation, accepted, at registration stage 5
# 25. user with physician invitation, accepted, scheduled appointment
# Create users with QOL referrals
# 26. user with QOL invitation, not yet accepted
# 27. user with QOL invitation, accepted, at registration stage 1
# 28. user with QOL invitation, accepted, at registration stage 2
# 29. user with QOL invitation, accepted, at registration stage 3
# 30. user with QOL invitation, accepted, at registration stage 4
# 31. user with QOL invitation, accepted, at registration stage 5
# 31. user with QOL invitation, accepted, scheduled appointment


# PatientGroup.create(name: "Wheat", category: "allergy", order: 9).allergens << Allergen.create(name: "wheat", description: "The grain of the wheat plant.")

# Create Tags
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Any Health Group")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Typical Healthy Family")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "IBS")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Ulcerative Colitis")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Crohn's Disease")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Type 1 Diabetes")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Type 2 Diabetes")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Cystic Fibrosis")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Food Allergy or Intolerance")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Celiac Disease")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "EoE")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "FPIES")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "CSID")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Gluten Intolerance")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Lactose Intolerance")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Health Groups", name: "Allergic Colitis")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Peanut")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Sesame")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Treenut")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Soy")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Wheat")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Fish")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Dairy")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Shellfish")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Egg")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Corn")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Top 8
Allergens")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Gluten")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Food Triggers", name: "Lactose")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Age", name: "Pregnancy")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Age", name: "Infants - New Mothers")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Age", name: "Infants 4-12 Months")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Age", name: "Toddlers")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Age", name: "School Age")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Age", name: "Teen")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Age", name: "College Age")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Age", name: "Adult")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Symptoms", name: "Poor Growth")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Symptoms", name: "Weight Loss")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Symptoms", name: "Weight Gain")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Symptoms", name: "Decreased Appetite")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Symptoms", name: "Reflux")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Symptoms", name: "Vomiting")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Symptoms", name: "Constipation")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Symptoms", name: "Diarrhea")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Dietary Preferences", name: "Vegetarian")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Dietary Preferences", name: "Vegan")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Dietary Preferences", name: "FODMAP")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "General", tag_category: "Dietary Preferences", name: "Kosher")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article High Level", name: "Nutrition")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article High Level", name: "Family Matters")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article High Level", name: "Shopping")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article High Level", name: "Cooking & Kitchen")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article High Level", name: "New Client/Diagnosis")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article High Level", name: "Behavior & Social")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article High Level", name: "Child Development")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article High Level", name: "Seasonal Meals & Menu")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article Low Level", name: "Supplements")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article Low Level", name: "Transition to Solids")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article Low Level", name: "Formula")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article Low Level", name: "Breastfeeding")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article Low Level", name: "Food/Ingredient Knowledge")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article Low Level", name: "Cooking Skills")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Article", tag_category: "Article Low Level", name: "Food Taste Variety & Enjoyment")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Meal Type", name: "Breakfast")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Meal Type", name: "Lunch")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Meal Type", name: "Dinner")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Meal Type", name: "Snack")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Meal Type", name: "Dessert")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Meal Type", name: "Beverage")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Meal Type", name: "Smoothies")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Meal Type", name: "Baby food")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Sub Meal Type", name: "Pasta")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Sub Meal Type", name: "Soups")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Sub Meal Type", name: "Salad")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Sub Meal Type", name: "Side dish")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Sub Meal Type", name: "Appetizers")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Sub Meal Type", name: "Condiments")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Cooking Technique", name: "Baked Good")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Cooking Technique", name: "Slow Cooked")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Cooking Technique", name: "Grilling")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Cooking Technique", name: "No Cook")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Eating Style", name: "Finger Foods")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Eating Style", name: "Pureed Foods")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Eating Style", name: "On the Go")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Eating Style", name: "Large Gathering")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Eating Style", name: "Cooking For 2")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Egg")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Chicken")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Fish")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Beef")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Pork")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Turkey")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Lamb")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Potato")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Rice")
Monologue::Tag.create(browseable: false, showcase: false, content_type: "Recipe", tag_category: "Main Ingredient", name: "Quinoa ")
