require 'redmine'

Redmine::Plugin.register :redmine_colleagues do
  name 'Colleagues'
  author 'Roman Shipiev'
  description 'Show all your colleagues (consist in same LDAP-domain). Plugin will not work for non-domain Users'
  version '0.0.3'
  url 'https://bitbucket.org/rubynovich/redmine_colleagues'
  author_url 'http://roman.shipiev.me'

  project_module :colleagues do
  end

  Redmine::MenuManager.map :top_menu do |menu| 

    parent = menu.exists?(:internal_intercourse) ? :internal_intercourse : :top_menu
    menu.push( :colleagues, {:controller => :colleagues, :action => :index}, 
               { :parent => parent,            
                 :caption => :colleagues_title, 
                 :if => Proc.new{ User.current.auth_source_id? }
               })
    
  end

  menu :project_menu, :colleagues, {:controller => :colleagues, :action => :index}, :caption => :colleagues_title, :param => :project_id, :if => Proc.new{ User.current.auth_source_id? }

end

if Rails::VERSION::MAJOR < 3
  require 'dispatcher'
  object_to_prepare = Dispatcher
else
  object_to_prepare = Rails.configuration
end

object_to_prepare.to_prepare do
  [:user].each do |cl|
    require "colleagues_#{cl}_patch"
  end

  [
    [User, ColleaguesPlugin::UserPatch]
  ].each do |cl, patch|
    cl.send(:include, patch) unless cl.included_modules.include? patch
  end
end
