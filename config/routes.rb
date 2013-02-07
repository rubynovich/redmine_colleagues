if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    resources :colleagues
    connect 'projects/:project_id/colleagues', :controller => :colleagues
#    connect 'projects/:project_id/colleagues/:id', :controller => :colleagues
  end
else
  ActionController::Routing::Routes.draw do |map|
    map.resources :colleagues
    map.connect 'projects/:project_id/colleagues', :controller => :colleagues
#    map.connect 'projects/:project_id/colleagues/:id', :controller => :colleagues
  end
end
