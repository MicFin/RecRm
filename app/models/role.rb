class Role < ActiveRecord::Base
  has_and_belongs_to_many :dietitians, :join_table => :dietitians_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
end
