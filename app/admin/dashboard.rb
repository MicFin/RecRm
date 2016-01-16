
ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    today = Date.today
    beginning_of_week = today.at_beginning_of_week
  
  end # content

      #   column do
      #   panel "Info" do
      #     para "Welcome to ActiveAdmin."
      #   end
      # end
end
