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
