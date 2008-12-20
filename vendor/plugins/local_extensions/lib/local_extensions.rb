require 'application'
require 'cached_model'

::ActionController::Base.append_view_path("#{RAILS_ROOT}/vendor/plugins/local_extensions/views")

class LocalController < ContentController
  layout :theme_layout

  if Blog.default && Blog.default.cache_option == "caches_action_with_params"
    caches_action_with_params :frontpage
  else
    caches_page :frontpage
  end

  def bryarlink
    /id_(\d+)/.match(params[:bryarid])
    begin
      article = Article.find_already_published($1)
      headers["Status"] = "301 Moved Permanently"
      redirect_to article.permalink_url
      return
    rescue ActiveRecord::RecordNotFound
      render :text => "Page not found", :status => 404
    end
  end

  def frontpage
    @frontpage = true;
    @articles = Article.find_already_published(
      :all, :order => 'created_at DESC',
      :limit => this_blog.limit_article_display
    )
    @page_title   = 'matijs.net'
  end
end

Article.class_eval do
  def pings_closed?
    !(allow_pings? && in_feedback_window?)
  end
end
