# == Schema Information
#
# Table name: food_diary_entries
#
#  id            :integer          not null, primary key
#  food_diary_id :integer
#  consumed_at   :datetime
#  food_item     :string(255)
#  location      :string(255)
#  note          :text
#  created_at    :datetime
#  updated_at    :datetime
#

class FoodDiaryEntry < ActiveRecord::Base
  belongs_to :food_diary
  default_scope { order('consumed_at DESC') }

  validates :consumed_at, presence: true, on: :create
  validates :consumed_at, presence: true, on: :update, :if => Proc.new { |food_diary_entry| food_diary_entry.consumed_at_changed?}
# validates :new_password_confirmation, presence: true, on: :create
# validates :new_password_confirmation, presence: true, on: :update, if: :password_changed?

  private 

  # def should_validate?
  #   new_record? || email.present?
  # end
end
