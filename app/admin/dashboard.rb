ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
  # menu priority: 2, label: "Dashboard #{Recipe.all.count}"
  content title: proc{ I18n.t("active_admin.dashboard") } do
    h1 "Total Recipes: #{Recipe.all.count}"
    today = Date.today
    beginning_of_week = today.at_beginning_of_week
    columns do
      column do
        panel "This week" do
          ul do
            li "#{Recipe.where(:created_at => beginning_of_week.beginning_of_day..today.end_of_day).count}"
          end  
        end 
      end   
      column do
        panel "Last week" do
          ul do
            li "#{Recipe.where(:created_at => 1.week.ago.beginning_of_week.beginning_of_day..1.week.ago.end_of_week.end_of_day).count}"
          end  
        end
      end  
      column do
        panel "2 weeks ago" do
          ul do
            li "#{Recipe.where(:created_at => 2.week.ago.beginning_of_week.beginning_of_day..2.week.ago.end_of_week.end_of_day).count}"
          end  
        end 
      end   
      column do
        panel "3 weeks ago" do
          ul do
            li "#{Recipe.where(:created_at => 3.week.ago.beginning_of_week.beginning_of_day..3.week.ago.end_of_week.end_of_day).count}"
          end  
        end 
      end   
      column do
        panel "4 weeks ago" do
          ul do
            li "#{Recipe.where(:created_at => 4.week.ago.beginning_of_week.beginning_of_day..4.week.ago.end_of_week.end_of_day).count}"
          end  
        end 
      end   
    end
    h3 "By Patient Group"
    columns do
        column do
          panel "Dairy Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).count}"
            end  
          end 
        end   
        column do
          panel "Egg Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Egg').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Egg').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Egg').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Egg').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Egg').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Egg').references(:patient_group).count}"
            end  
          end
        end 
        column do
          panel "Soy Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).count}"
            end  
          end
        end   
        column do
          panel "Wheat Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Wheat').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Wheat').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Wheat').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Wheat').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Wheat').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Wheat').references(:patient_group).count}"
            end  
          end
        end  
        column do
          panel "Fish Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).count}"
            end  
          end
        end  
        column do
          panel "Shellfish Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).count}"
            end  
          end
        end 
        column do
          panel "Tree Nut Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).count}"
            end  
          end
        end   
        column do
          panel "Peanut Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).count}"
            end  
          end
        end           
    end # columns
    columns do
        column do
          panel "Top 8" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
            end  
          end 
        end  
        column do
          panel "Dairy/Soy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
            end  
          end 
        end   
        column do
          panel "Dairy/Wheat" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Wheat').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
            end  
          end 
        end  
        column do
          panel "Dairy/Egg/Soy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Egg').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
            end  
          end 
        end    
        column do
          panel "Dairy/Peanut/Soy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).where('patient_groups.name = ?', 'Soy').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
            end  
          end 
        end  
        column do
          panel "Tree Nut/Peanut" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).where('patient_groups.name = ?', 'Peanut').references(:patient_group).references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
            end  
          end 
        end  
        column do
          panel "Fish/Shellfish" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).references(:patient_group).count}"
              li "Breakfast: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snack: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).references(:patient_group).includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
            end  
          end 
        end  
      end
    h3 "By Meal/Course"
    columns do  
        column do
          panel "Breakfast" do
            ul do
              li "#{Recipe.includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
            end  
          end
        end 
        column do
          panel "Lunch" do
            ul do
              li "#{Recipe.includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
            end  
          end
        end   
        column do
          panel "Dinner" do
            ul do
              li "#{Recipe.includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
            end  
          end
        end  
        column do
          panel "Snack" do
            ul do
              li "#{Recipe.includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count}"
            end  
          end
        end  
        column do
          panel "Appetizer" do
            ul do
              li "#{Recipe.includes(:characteristics).where('characteristics.name = ?', 'Appetizer').references(:characteristic).count}"
            end  
          end
        end 
        column do
          panel "Dessert" do
            ul do
              li "#{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Dessert').references(:patient_group).count}"
            end  
          end
        end   
        column do
          panel "Soup" do
            ul do
              li "#{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Soup').references(:patient_group).count}"
            end  
          end
        end     
        column do
          panel "Salad" do
            ul do
              li "#{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Salad').references(:patient_group).count}"
            end  
          end
        end           
        column do
          panel "Beverage" do
            ul do
              li "#{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Beverage').references(:patient_group).count}"
            end  
          end
        end  
        column do
          panel "Condiments" do
            ul do
              li "#{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Condiments').references(:patient_group).count}"
            end  
          end
        end     
    end # columns    
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    h3 "By Chef"
    groups = Dietitian.all.in_groups(2)
    columns do
    groups[0].each do |dietitian|
      column do
        panel "#{dietitian.email}" do
          ul do
          # Post.recent(5).map do |post|
          #   li link_to(post.title, admin_post_path(post))
              li "Total: #{dietitian.recipes.count}"
              li "This Week: #{dietitian.recipes.where(:created_at => beginning_of_week.beginning_of_day..today.end_of_day).count}"
              li "Last Week: #{dietitian.recipes.where(:created_at => 1.week.ago.beginning_of_week.beginning_of_day..1.week.ago.end_of_week.end_of_day).count}"
              li "2 Weeks Ago: #{dietitian.recipes.where(:created_at => 2.week.ago.beginning_of_week.beginning_of_day..2.week.ago.end_of_week.end_of_day).count}"
              li "3 Weeks Ago: #{dietitian.recipes.where(:created_at => 3.week.ago.beginning_of_week.beginning_of_day..3.week.ago.end_of_week.end_of_day).count}"
              li "4 Weeks Ago: #{dietitian.recipes.where(:created_at => 4.week.ago.beginning_of_week.beginning_of_day..4.week.ago.end_of_week.end_of_day).count}"
              br
              li "Breakfast: #{dietitian.recipes.includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{dietitian.recipes.includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{dietitian.recipes.includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snacks: #{dietitian.recipes.includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              br
              li "Made for Dairy: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).count}"
              li "Made for Egg: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Egg').references(:patient_group).count}"
              li "Made for Soy: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).count}"
              li "Made for Wheat: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Wheat').references(:patient_group).count}"
              li "Made for Fish: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).count}"
              li "Made for Shellfish: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).count}"
              li "Made for Tree Nut: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).count}"
              li "Made for Peanut: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).count}"
          end
        end
      end
    end
    end
    columns do
    groups[1].compact!.each do |dietitian|
      column do
        panel "#{dietitian.email}" do
          ul do
          # Post.recent(5).map do |post|
          #   li link_to(post.title, admin_post_path(post))
              li "Total: #{dietitian.recipes.count}"
              li "This Week: #{dietitian.recipes.where(:created_at => beginning_of_week.beginning_of_day..today.end_of_day).count}"
              li "Last Week: #{dietitian.recipes.where(:created_at => 1.week.ago.beginning_of_week.beginning_of_day..1.week.ago.end_of_week.end_of_day).count}"
              li "2 Weeks Ago: #{dietitian.recipes.where(:created_at => 2.week.ago.beginning_of_week.beginning_of_day..2.week.ago.end_of_week.end_of_day).count}"
              li "3 Weeks Ago: #{dietitian.recipes.where(:created_at => 3.week.ago.beginning_of_week.beginning_of_day..3.week.ago.end_of_week.end_of_day).count}"
              li "4 Weeks Ago: #{dietitian.recipes.where(:created_at => 4.week.ago.beginning_of_week.beginning_of_day..4.week.ago.end_of_week.end_of_day).count}"
              br
              li "Breakfast: #{dietitian.recipes.includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              li "Lunch: #{dietitian.recipes.includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count}"
              li "Dinner: #{dietitian.recipes.includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count}"
              li "Snacks: #{dietitian.recipes.includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count}"
              br
              li "Made for Dairy: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Dairy').references(:patient_group).count}"
              li "Made for Egg: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Egg').references(:patient_group).count}"
              li "Made for Soy: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).count}"
              li "Made for Wheat: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Wheat').references(:patient_group).count}"
              li "Made for Fish: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Fish').references(:patient_group).count}"
              li "Made for Shellfish: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Shellfish').references(:patient_group).count}"
              li "Made for Tree Nut: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Tree Nut').references(:patient_group).count}"
              li "Made for Peanut: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).count}"
          end
        end
      end
    end
    end # columns

  end # content

      #   column do
      #   panel "Info" do
      #     para "Welcome to ActiveAdmin."
      #   end
      # end
end
