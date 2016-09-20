Rails.application.routes.draw do
  # Front page
  get 'frontpage', :to => 'local#frontpage'
end
