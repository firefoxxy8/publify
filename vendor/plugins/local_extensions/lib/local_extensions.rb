::ActionController::Base.append_view_path("#{RAILS_ROOT}/vendor/plugins/local_extensions/views")

class LocalController < ContentController
  layout :theme_layout

  if Blog.default && Blog.default.cache_option == "caches_action_with_params"
    caches_action_with_params :frontpage
  else
    caches_page :frontpage
  end

  def frontpage
    @frontpage = true;
    @articles = Article.find_already_published(
      :all, :order => 'created_at DESC',
      :limit => this_blog.limit_article_display
    )
    @page_title = 'matijs.net'
  end
end
