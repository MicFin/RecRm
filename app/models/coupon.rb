class Coupon < ActiveRecord::Base

  has_many :coupon_redemptions

  def self.generate_code   
    now = Time.now.utc.to_date
    age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    super(age) #must add this otherwise you need to add this thing and place the value which you want to save. 
  end

 def code=(value)
    # custom actions
    ###
    write_attribute(:code, value)
    # this is same as self[:code] = value
  end


end
