ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
  # menu priority: 2, label: "Dashboard #{Recipe.all.count}"
  content title: proc{ I18n.t("active_admin.dashboard") } do
    para "Total Recipes: #{Recipe.all.count}"
    columns do
        column do
          panel "Celiac" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Celiac').references(:patient_group).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Celiac').references(:patient_group).count}"
            end  
          end 
        end   
        column do
          panel "Soy Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Soy').references(:patient_group).count}"
            end  
          end
        end 
        column do
          panel "Peanut Allergy" do
            ul do
              li "Made for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).count}"
              li "Safe for: #{Recipe.includes(:patient_groups).where('patient_groups.name = ?', 'Peanut').references(:patient_group).count}"
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
    columns do
      column do
        panel "Recipes by Chef" do
          ul do
          # Post.recent(5).map do |post|
          #   li link_to(post.title, admin_post_path(post))
            Dietitian.all.each do |dietitian|
              li "#{dietitian.email} #{dietitian.recipes.count}"
              li  "Celiac: #{dietitian.recipes.includes(:patient_groups).where('patient_groups.name = ?', 'Celiac').references(:patient_group).count}"
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end # columns

  end # content
end
