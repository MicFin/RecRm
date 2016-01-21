# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default("")
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  phone_number           :string(255)
#  date_of_birth          :date
#  sex                    :string(255)
#  height_inches          :integer
#  weight_ounces          :integer
#  stripe_id              :text
#  family_note            :text
#  family_role            :string(255)
#  early_access           :boolean          default(FALSE)
#  tara_referral          :boolean          default(FALSE), not null
#  zip_code               :string(255)
#  qol_referral           :boolean          default(FALSE), not null
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  due_date               :datetime
#  registration_stage     :integer          default(0)
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  time_zone              :string(255)
#  physician_referral     :boolean          default(FALSE)
#  provider               :boolean          default(FALSE)
#  hospitals_or_practices :text
#  academic_affiliations  :text
#  specialty              :string(255)
#  subspecialty           :string(255)
#  fax                    :string(255)
#  terms_accepted         :boolean
#  monologue_user_id      :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
