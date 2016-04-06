# == Schema Information
#
# Table name: monologue_tags
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  tag_category :string(255)
#

class Monologue::TagsController < Monologue::ApplicationController
  def show

    @showcase_tags = Monologue::Tag.showcase_tags
    @tag = retrieve_tag
    if @tag
      @page = nil
      @posts = @tag.posts_with_tag
    else
      redirect_to :root ,notice: "No post found with label \"#{params[:tag]}\""
    end

  end

  private
  def retrieve_tag
    Monologue::Tag.where("lower(name) = ?", params[:tag].mb_chars.to_s.downcase).first
  end
end
