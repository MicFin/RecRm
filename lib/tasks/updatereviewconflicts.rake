namespace :updatereviewconflicts do
    desc "Updates review conflicts risk level"
 task update_risk_level: :environment do
    puts "Updating review conflict risk levels"
    ReviewConflict.all.each do |review_conflict|
      if review_conflict.risk_level == nil
        review_conflict.risk_level = 300
      elsif review_conflict.risk_level == 4
        review_conflict.risk_level = 300
      elsif review_conflict.risk_level == 3
        review_conflict.risk_level = 300
      elsif review_conflict.risk_level == 2
        review_conflict.risk_level = 200
      else
        review_conflict.risk_level = 100
      end
      review_conflict.save
    end
  end
end