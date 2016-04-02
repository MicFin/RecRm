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

  validates :user_id, presence: true
  validates :title, :content, :url, :published_at, presence: true
  validates :url, uniqueness: true
  validate :url_do_not_start_with_slash

  attr_accessor :tags_major_persona, :tags_sub_persona, :tags_theme


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
