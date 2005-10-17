ActionController::Routing::Routes.draw do |map|

  # default   
  map.index '', :controller  => 'articles', :action => 'frontpage'
  map.index 'blog', :controller  => 'articles', :action => 'index'
  #map.index_page 'blog/page/:page', :controller  => 'articles', :action => 'index', :page => /\d/
  map.admin 'blog/admin', :controller  => 'admin/general', :action => 'index'
  
  # admin/comments controller needs parent article id
  map.connect 'blog/admin/comments/article/:article_id/:action/:id',
    :controller => 'admin/comments', :action => nil, :id => nil
  map.connect 'blog/admin/trackback/article/:article_id/:action/:id',
    :controller => 'admin/trackback', :action => nil, :id => nil
  map.connect 'admin/content/:action/:id', :controller => 'admin/content'

  # make rss feed urls pretty and let them end in .xml
  # this improves caches_page because now apache and webrick will send out the 
  # cached feeds with the correct xml mime type. 
  # MvZ: limit number of feeds
  #map.xml 'blog/xml/:action/feed.xml', :controller => 'xml'
  map.xml 'blog/xml/rss/feed.xml', :controller  => 'xml', :action => 'rss'
  map.xml 'blog/xml/atom/feed.xml', :controller  => 'xml', :action => 'atom'
  #map.xml 'blog/xml/articlerss/:id/feed.xml', :controller => 'xml', :action => 'articlerss'

  # allow neat perma urls
  map.connect 'blog/:bryarid', :controller  => 'articles', :action => 'permalink', :bryarid => /id_\d*/
  map.connect 'blog/:page',
    :controller => 'articles', :action => 'index', :page => nil,
    :requirements => { :page => /page\d+/ }
  map.connect 'blog/:year/:page',
    :controller => 'articles', :action => 'find_by_date', :page => nil,
    :requirements => { :page => /page\d+/, :year => /\d{4}/ }
  map.connect 'blog/:year/:month/:page',
    :controller => 'articles', :action => 'find_by_date', :page => nil,
    :requirements => { :page => /page\d+/, :year => /\d{4}/, :month => /\d{1,2}/ }
  map.connect 'blog/:year/:month/:day/:page',
    :controller => 'articles', :action => 'find_by_date', :page => nil,
    :requirements => { :page => /page\d+/, :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/ }
#  map.connect 'blog/:year/:month/:day/:title',
#    :controller => 'articles', :action => 'permalink',
#    :requirements => { :year => /\d{4}/, :day => /\d{1,2}/, :month => /\d{1,2}/ }

#map.connect 'pages/*name',:controller => 'articles', :action => 'view_page'

  map.connect 'stylesheets/theme/:filename',
    :controller => 'theme', :action => 'stylesheets'
  map.connect 'javascript/theme/:filename',
    :controller => 'theme', :action => 'javascript'
  map.connect 'images/theme/:filename',
    :controller => 'theme', :action => 'images'

  # Kill attempts to connect directly to the theme controller.
  # Ideally we'd disable these by removing the default route (below),
  # but that breaks too many things for Typo 2.5.
  map.connect 'theme/*stuff',
    :controller => 'theme', :action => 'error'
     
  # Allow legacy urls to still work
  map.connect 'blog/:controller/:action/:id/:page', :page => nil,
    :requirements => { :page => /page\d+/ }
end
