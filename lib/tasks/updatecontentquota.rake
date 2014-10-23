namespace :updatecontentquota do
    desc "Update quotas with a nil value"
 task update_from_nil: :environment do
    puts "Updating quotas with a nil value"
    ContentQuota.all.each do |content_quota|
      if content_quota.recipes == nil
        content_quota.recipes = 0
      end
      if content_quota.quality_reviews == nil
        content_quota.quality_reviews = 0
      end
      if content_quota.review_conflicts == nil
        content_quota.review_conflicts = 0
      end
      content_quota.save
    end
  end
end