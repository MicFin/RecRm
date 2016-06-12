class AddProfessionalDetailsToDietitians < ActiveRecord::Migration
  def change
    add_column :dietitians, :undergraduate_education, :string
    add_column :dietitians, :graduate_education, :string
    add_column :dietitians, :professional_experience_first, :string
    add_column :dietitians, :professional_experience_second, :string
    add_column :dietitians, :professional_experience_third, :string
    add_column :dietitians, :professional_experience_fourth, :string
    add_column :dietitians, :professional_experience_fifth, :string
    add_column :dietitians, :introduction, :text
  end
end
