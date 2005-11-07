ActionController::Routing::Routes.draw do |map|

  # default   
  map.index '', :controller  => 'articles', :action => 'frontpage'
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
  #map.xml 'blog/xml/articlerss/:id/feed.xml', :controller => 'xml', :action => 'articlerss'
  #map.xml 'blog/xml/commentrss/feed.xml', :controller => 'xml', :action => 'commentrss'
  #map.xml 'blog/xml/trackbackrss/feed.xml', :controller => 'xml', :action => 'trackbackrss'
  
  # MvZ: Limit feed types.
  map.xml 'blog/xml/rss/feed.xml', :controller  => 'xml', :action => 'feed', :type => 'feed', :format => 'rss'
  map.xml 'blog/xml/atom/feed.xml', :controller  => 'xml', :action => 'feed', :type => 'feed', :format => 'atom'
  #map.xml 'blog/xml/:format/feed.xml', :controller => 'xml', :action => 'feed', :type => 'feed'
  #map.xml 'blog/xml/:format/:type/feed.xml', :controller => 'xml', :action => 'feed'
  #map.xml 'blog/xml/:format/:type/:id/feed.xml', :controller => 'xml', :action => 'feed'
  
  # allow neat perma urls
  map.connect 'blog',
    :controller => 'articles', :action => 'index'
  map.connect 'blog/page/:page',
    :controller => 'articles', :action => 'index',
    :page => /\d+/

  #TODO
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

  map.connect 'blog/:bryarid', :controller  => 'articles', :action => 'permalink', :bryarid => /id_\d*/

#  map.connect 'blog/:year/:month/:day/:title',
#    :controller => 'articles', :action => 'permalink',
#    :year => /\d{4}/, :day => /\d{1,2}/, :month => /\d{1,2}/

  map.connect 'blog/category/:id',
    :controller => 'articles', :action => 'category'
  map.connect 'blog/category/:id/page/:page',
    :controller => 'articles', :action => 'category',
    :page => /\d+/

#map.connect 'pages/*name',:controller => 'articles', :action => 'view_page'

  map.connect 'stylesheets/theme/:filename',
    :controller => 'theme', :action => 'stylesheets'
  map.connect 'javascript/theme/:filename',
    :controller => 'theme', :action => 'javascript'
  map.connect 'images/theme/:filename',
    :controller => 'theme', :action => 'images'

  map.connect 'plugins/filters/:filter/:public_action',
    :controller => 'textfilter', :action => 'public_action'

  # Kill attempts to connect directly to the theme controller.
  # Ideally we'd disable these by removing the default route (below),
  # but that breaks too many things for Typo 2.5.
  map.connect 'theme/*stuff',
    :controller => 'theme', :action => 'error'
     
  # Allow legacy urls to still work
  map.connect 'blog/:controller/:action/:id'
end
