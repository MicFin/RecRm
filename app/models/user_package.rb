class UserPackage < ActiveRecord::Base
  belongs_to :user
  belongs_to :package
  # after_create :generate_appointments, if: :author_wants_emails?,
  #   unless: Proc.new { |comment| comment.article.ignore_comments? }
  has_one :purchase, as: :purchasable

  private

  def generate_appointments

    # create appointments to be added to users queue

  end
end