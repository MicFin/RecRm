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

Monologue::Tag.create(content_type: "General", tag_category: "Health Groups", name: "Celiac")
Monologue::Tag.create(content_type: "General", tag_category: "Food Triggers", name: "Peanuts")
Monologue::Tag.create(content_type: "General", tag_category: "Symptoms", name: "Vomiting")
Monologue::Tag.create(content_type: "General", tag_category: "Dietary Preferances", name: "Paleo")
Monologue::Tag.create(content_type: "General", tag_category: "Age", name: "Child")
Monologue::Tag.create(content_type: "Article", tag_category: "High Level Theme", name: "New Moms")
Monologue::Tag.create(content_type: "Article", tag_category: "Low Level Theme", name: "Moms")
Monologue::Tag.create(content_type: "Recipe", tag_category: "Meal Type", name: "Dinner")
Monologue::Tag.create(content_type: "Recipe", tag_category: "Sub Meal Type", name: "Salad")
Monologue::Tag.create(content_type: "Recipe", tag_category: "Cooking Techniques", name: "Baked Goods")
Monologue::Tag.create(content_type: "Recipe", tag_category: "Eating Style", name: "On The Go")
Monologue::Tag.create(content_type: "Recipe", tag_category: "Main Ingredient", name: "Chicken")



