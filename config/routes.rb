if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    resources :colleagues
    match 'projects/:project_id/colleagues' => "colleagues#index"
#    connect 'projects/:project_id/colleagues/:id', :controller => :colleagues
  end
else
  ActionController::Routing::Routes.draw do |map|
    map.resources :colleagues
    map.connect 'projects/:project_id/colleagues', :controller => :colleagues, :action => :index
#    map.connect 'projects/:project_id/colleagues/:id', :controller => :colleagues
  end
end
