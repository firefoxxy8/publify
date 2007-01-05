ActionController::Routing::Routes.draw do |map|

  # front page
  map.index '', :controller  => 'articles', :action => 'frontpage'

  # default
  map.index 'blog', :controller  => 'articles', :action => 'index'
  map.admin 'blog/admin', :controller  => 'admin/general', :action => 'index'

  # admin/comments controller needs parent article id
  map.connect 'blog/admin/comments/article/:article_id/:action/:id',
    :controller => 'admin/comments', :action => nil, :id => nil
  map.connect 'blog/admin/trackbacks/article/:article_id/:action/:id',
    :controller => 'admin/trackbacks', :action => nil, :id => nil
  map.connect 'blog/admin/content/:action/:id', :controller => 'admin/content'

  # make rss feed urls pretty and let them end in .xml
  # this improves caches_page because now apache and webrick will send out the
  # cached feeds with the correct xml mime type.
  map.xml 'blog/xml/itunes/feed.xml', :controller => 'xml', :action => 'itunes'
  map.xml 'blog/xml/articlerss/:id/feed.xml', :controller => 'xml', :action => 'articlerss'
  map.xml 'blog/xml/commentrss/feed.xml', :controller => 'xml', :action => 'commentrss'
  map.xml 'blog/xml/trackbackrss/feed.xml', :controller => 'xml', :action => 'trackbackrss'

  map.xml 'blog/xml/:format/feed.xml', :controller => 'xml', :action => 'feed', :type => 'feed'
  map.xml 'blog/xml/:format/:type/feed.xml', :controller => 'xml', :action => 'feed'
  map.xml 'blog/xml/:format/:type/:id/feed.xml', :controller => 'xml', :action => 'feed'
  map.xml 'blog/xml/rss', :controller => 'xml', :action => 'feed', :type => 'feed', :format => 'rss'
  #map.xml 'sitemap.xml', :controller => 'xml', :action => 'feed', :format => 'googlesitemap', :type => 'sitemap'

  # allow neat perma urls
  map.connect 'blog',
    :controller => 'articles', :action => 'index'
  map.connect 'blog/page/:page',
    :controller => 'articles', :action => 'index',
    :page => /\d+/

  map.connect 'blog/:year/:month/:day',
    :controller => 'articles', :action => 'find_by_date',
    :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/
  map.connect 'blog/:year/:month',
    :controller => 'articles', :action => 'find_by_date',
    :year => /\d{4}/, :month => /\d{1,2}/
  map.connect 'blog/:year',
    :controller => 'articles', :action => 'find_by_date',
    :year => /\d{4}/

  map.connect 'blog/:year/:month/:day/page/:page',
    :controller => 'articles', :action => 'find_by_date',
    :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :page => /\d+/
  map.connect 'blog/:year/:month/page/:page',
    :controller => 'articles', :action => 'find_by_date',
    :year => /\d{4}/, :month => /\d{1,2}/, :page => /\d+/
  map.connect 'blog/:year/page/:page',
    :controller => 'articles', :action => 'find_by_date',
    :year => /\d{4}/, :page => /\d+/

  map.connect 'blog/:year/:month/:day/:title',
    :controller => 'articles', :action => 'permalink',
    :year => /\d{4}/, :day => /\d{1,2}/, :month => /\d{1,2}/

  # Old ids from Bryar
  map.connect 'blog/:bryarid',
    :controller  => 'articles', :action => 'bryarlink', :bryarid => /id_\d*/

  map.connect 'blog/category/:id',
    :controller => 'articles', :action => 'category'
  map.connect 'blog/category/:id/page/:page',
    :controller => 'articles', :action => 'category',
    :page => /\d+/

  map.connect 'blog/tag/:id',
    :controller => 'articles', :action => 'tag'
  map.connect 'blog/tag/:id/page/:page',
  map.connect 'stylesheets/theme/:filename',
    :controller => 'theme', :action => 'stylesheets', :filename => /.*/
  map.connect 'javascripts/theme/:filename',
    :controller => 'theme', :action => 'javascript', :filename => /.*/
  map.connect 'images/theme/:filename',
    :controller => 'theme', :action => 'images', :filename => /.*/

  # For the tests
  map.connect 'blog/theme/static_view_test', :controller => 'theme', :action => 'static_view_test'

  map.connect 'plugins/filters/:filter/:public_action',
    :controller => 'textfilter', :action => 'public_action'

  # Work around the Bad URI bug
  %w{ accounts articles backend files live sidebar textfilter xml }.each do |i|
    map.connect "blog/#{i}", :controller => "#{i}", :action => 'index'
    map.connect "blog/#{i}/:action", :controller => "#{i}"
    map.connect "blog/#{i}/:action/:id", :controller => i, :id => nil
  end

  %w{blacklist cache categories comments content feedback general pages
     resources sidebar textfilters themes trackbacks users}.each do |i|
    map.connect "blog/admin/#{i}", :controller => "admin/#{i}", :action => 'index'
    map.connect "blog/admin/#{i}/:action/:id", :controller => "admin/#{i}", :action => nil, :id => nil
  end

  # map.connect 'blog/:controller/:action/:id'
  map.connect '*from', :controller => 'redirect', :action => 'redirect'
end
