class PagesController < ApplicationController
  def home
  	if signed_in?
	  	@micropost = current_user.microposts.build if signed_in?
	  	@feed_items = current_user.feed.paginate(page: params[:page])
	  end
  end

  def contact
  end

  def about
  end

  def help
  end
end