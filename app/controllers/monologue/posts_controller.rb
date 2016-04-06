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

class Monologue::PostsController < Monologue::ApplicationController
  def index
    @page = params[:page].nil? ? 1 : params[:page]
    @posts = Monologue::Post.page(@page).published
    @post = Monologue::Post.published.last
    @showcase_tags = Monologue::Tag.showcase_tags
  end

  def show
    if monologue_current_user
      @post = Monologue::Post.default.where("url = :url", {url: params[:post_url]}).first
    else
      @post = Monologue::Post.published.where("url = :url", {url: params[:post_url]}).first
    end
    if @post.nil?
      not_found
    end

    @showcase_tags = Monologue::Tag.showcase_tags
    @tags = Monologue::Tag.last(10)
    # monologue application controller
    @recent_posts
  end

  def feed
    @posts = Monologue::Post.published.limit(25)
    if params[:tags].present?
      tags = Monologue::Tag.where(name: params[:tags].split(",")).pluck(:id)
      @posts = @posts.joins(:taggings).where("monologue_taggings.tag_id in (?)", tags)
    end
    render 'feed', layout: false
  end
end
