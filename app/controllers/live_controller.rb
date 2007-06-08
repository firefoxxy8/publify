class LiveController < ContentController
  session :off

  def search
    @search = params[:q]
    @articles = this_blog.published_articles.search(@search)
    headers["Content-Type"] = "text/html; charset=utf-8"
  end

end
