# == Schema Information
#
# Table name: monologue_posts
#
#  id                                    :integer          not null, primary key
#  published                             :boolean
#  created_at                            :datetime
#  updated_at                            :datetime
#  user_id                               :integer
#  title                                 :string(255)
#  content                               :text
#  url                                   :string(255)
#  published_at                          :datetime
#  nutrition_review_required             :boolean          default(FALSE)
#  culinary_review_required              :boolean          default(FALSE)
#  medical_review_required               :boolean          default(FALSE)
#  marketing_review_required             :boolean          default(FALSE)
#  editorial_initial_review_required     :boolean          default(TRUE)
#  final_sign_off_date                   :datetime
#  author_id                             :integer
#  call_to_action_id                     :integer
#  nutrition_review_completed_at         :datetime
#  medical_review_completed_at           :datetime
#  culinary_review_completed_at          :datetime
#  marketing_review_completed_at         :datetime
#  editorial_initial_review_completed_at :datetime
#  specs                                 :text
#  specs_completed                       :boolean
#  specs_completed_at                    :datetime
#  marketing_review_complete             :boolean          default(FALSE)
#  nutrition_review_complete             :boolean          default(FALSE)
#  culinary_review_complete              :boolean          default(FALSE)
#  medical_review_complete               :boolean          default(FALSE)
#  editorial_initial_review_complete     :boolean          default(FALSE)
#  editorial_final_review_required       :boolean          default(TRUE)
#  editorial_final_review_complete       :boolean          default(FALSE)
#  editorial_final_review_completed_at   :datetime
#  marketing_reviewer_id                 :integer
#  editorial_initial_reviewer_id         :integer
#  nutrition_reviewer_id                 :integer
#  culinary_reviewer_id                  :integer
#  medical_reviewer_id                   :integer
#  editorial_final_reviewer_id           :integer
#  spec_author_id                        :integer
#  call_to_action_activated              :boolean
#  author_complete                       :boolean
#  author_completed_at                   :datetime
#  content_type                          :string(255)
#  public                                :boolean
#

class Monologue::Post < ActiveRecord::Base
  has_many :taggings
  has_many :tags, -> { order "id ASC" }, through: :taggings, dependent: :destroy
  before_validation :generate_url

  belongs_to :user

  belongs_to :author, :class_name => "User", :foreign_key => "author_id"

  scope :default,  -> {order("published_at DESC, monologue_posts.created_at DESC, monologue_posts.updated_at DESC") }
  scope :published, -> { default.where(published: true).where("published_at <= ?", DateTime.now) }
  scope :public_blog, -> { default.where(public: true).where("published_at <= ?", DateTime.now) }

  default_scope{includes(:tags)}

  before_save :update_completed_reviews

  validates :user_id, presence: true
  validates :title, :content, :url, :published_at, presence: true
  validates :url, uniqueness: true
  validate :url_do_not_start_with_slash

  attr_accessor :tags_major_persona, :tags_sub_persona, :tags_theme

  def self.fetch_all_work_in_progress
    all_content = {
      "need_specs"=> [],
      "need_authorship"=> [],
      "need_editorial_initial_review"=> [],
      "need_nutrition_review"=> [],
      "need_culinary_review"=> [],
      "need_medical_review"=> [],
      "need_marketing_review"=> [],
      "need_editorial_final_review"=> [],
      "need_publishing"=> [],
    }
    default.where(published: false).each do |post|
      
      if post.specs_completed != true 
        all_content["need_specs"] << post
      elsif post.author_complete != true
        all_content["need_authorship"] << post
      elsif post.editorial_initial_review_complete != true 
        all_content["need_editorial_initial_review"] << post
      elsif post.nutrition_review_required && post.nutrition_review_complete != true
        all_content["need_nutrition_review"] << post
      elsif post.culinary_review_required && post.culinary_review_complete != true
        all_content["need_culinary_review"] << post
      elsif post.medical_review_required && post.medical_review_complete != true
        all_content["need_medical_review"] << post
      elsif post.marketing_review_required && post.marketing_review_complete != true
        all_content["need_marketing_review"] << post
      elsif post.editorial_final_review_complete != true
        all_content["need_editorial_final_review"] << post
      elsif post.published != true
        all_content["need_publishing"] << post
      else
      end
    end
    return all_content
  end

  def self.fetch_all_completed
    all_content = {
      "not_published"=> [],
      "published"=> [],
      "public"=> [],
    }
    default.where(editorial_final_review_complete: true).each do |post|
      if post.published != true 
        all_content["not_published"] << post
      elsif post.public != true
        all_content["published"] << post
      else 
        all_content["public"] << post
      end
    end
    return all_content
  end

  def current_stage
    if self.specs_completed == false 
      return 1
    elsif self.author_complete == false
      return 2
    elsif self.editorial_initial_review_complete == false 
      return 3
    elsif self.nutrition_review_complete == false
      return 4
    elsif self.culinary_review_complete == false
      return 5
    elsif self.medical_review_complete == false
      return 6
    elsif self.marketing_review_complete == false
      return 7
    elsif self.editorial_final_review_complete == false
      return 8
    elsif self.published == false
      return 9
    elsif self.public == false
      return 10
    else
      return 0
    end
  end
  def tags_major_persona
    self.tags.where(tag_category: "major persona").map { |tag| tag.name }.join(", ") if self.tags
  end

  def tags_sub_persona
    self.tags.where(tag_category: "sub persona").map { |tag| tag.name }.join(", ") if self.tags
  end

  def tags_theme
    self.tags.where(tag_category: "theme").map { |tag| tag.name }.join(", ") if self.tags
  end
  # def tags_major_persona= tags_attr
  #   tags_array = tags_attr.split(",");
  #   tags_array.map(&:strip).reject(&:blank?).map do |tag|
  #     Monologue::Tag.where(name: tag).where(tag_category: "major persona").first_or_create
  #   end
  # end
  # def tags_sub_persona
  #   self.tags.map { |tag| tag.name }.join(", ") if self.tags
  # end
  # def tags_theme
  #   self.tags.map { |tag| tag.name }.join(", ") if self.tags
  # end

  # def tag_list= tags_attr
  #   
  #   self.tags = tags_attr
  # end

  # def tag_list= tags_attr
  #   self.tag!(tags_attr.split(","))
  # end

  # def tag_list
  #   self.tags.map { |tag| tag.name }.join(", ") if self.tags
  # end

  # def tag!(tags_attr)
  #   self.tags = tags_attr.map(&:strip).reject(&:blank?).map do |tag|
  #     Monologue::Tag.where(name: tag).first_or_create
  #   end
  # end

  def full_url
    "#{Monologue::Engine.routes.url_helpers.root_path}#{self.url}"
  end

  def published_in_future?
    self.published && self.published_at > DateTime.now
  end

  def self.page p
    paged_results(p, Monologue::Config.posts_per_page || 10, false)
  end

  def self.listing_page(p)
    paged_results(p, Monologue::Config.admin_posts_per_page || 50, true)
  end

  def self.total_pages
    @number_of_pages
  end

  def self.set_total_pages per_page
    @number_of_pages = self.count / per_page + (self.count % per_page == 0 ? 0 : 1)
  end

  private


  def update_completed_reviews
    array_of_review_types = [
      "editorial_initial_review_complete", 
      "nutrition_review_complete",
      "specs_completed",
      "author_complete",
      "editorial_initial_review_complete",
      "nutrition_review_complete",
      "culinary_review_complete",
      "medical_review_complete",
      "marketing_review_complete",
      "editorial_final_review_complete",
      "published",
    ]
    array_of_review_types.each do |review_type|
      if self.changes.has_key?(review_type)
        if self.changes[review_type][1] == false 
          if review_type == "specs_completed" || review_type == "published"
            self.send(review_type+"_at=", nil) 
          else
            self.send(review_type+"d_at=", nil) 
          end
        else
          if review_type == "specs_completed" || review_type == "published"
            self.send(review_type+"_at=", DateTime.now)   
          else
            self.send(review_type+"d_at=", DateTime.now)  
          end
        end
      end
    end
  end

  def self.paged_results(p, per_page, admin)
    set_total_pages(per_page)
    p = (p.nil? ? 0 : p.to_i - 1)
    offset =  p * per_page
    if admin
      default.limit(per_page).offset(offset)
    else
      limit(per_page).offset(offset)
    end
  end

  def generate_url
    return unless self.url.blank?
    year = self.published_at.class == ActiveSupport::TimeWithZone ? self.published_at.year : DateTime.now.year
    self.url = "#{year}/#{self.title.parameterize}"
  end

  def url_do_not_start_with_slash
    errors.add(:url, I18n.t("activerecord.errors.models.monologue/post.attributes.url.start_with_slash")) if self.url.start_with?("/")
  end
end
