module BryarLink
  def bryarlink
    /id_(\d+)/.match(params[:bryarid])
    begin
      article = this_blog.published_articles.find($1)
      headers["Status"] = "301 Moved Permanently"
      redirect_to article.permalink_url
      return
    rescue ActiveRecord::RecordNotFound
      render :text => "Page not found", :status => 404
    #rescue
    #  render :text => "Internal server error", :status => 500
    end
  end
end

module FrontPage
  def frontpage
    @frontpage = true;
    @articles = this_blog.articles.find_published(
      :all, :order => 'created_at DESC',
      :limit => this_blog.limit_article_display
    )
    @page_title   = 'matijs.net'
  end
end
