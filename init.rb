require 'redmine'

Redmine::Plugin.register :redmine_colleagues do
  name 'Коллеги'
  author 'Roman Shipiev'
  description 'Отображает всех коллег пользователя (включенных в один домен). Пользователям, которые авторизуются не через домен (LDAP) -- модуль не доступен. Отображается как базовая информация (Имя, Фамилия, E-Mail), так и дополнительная (customfields).'
  version '0.0.3'
  url 'http://github.com/rubynovich/redmine_colleagues'
  author_url 'http://roman.shipiev.me'

  project_module :colleagues do
  end

  menu :project_menu, :colleagues, {:controller => :colleagues, :action => :index}, :caption => :colleagues_title, :param => :project_id, :if => Proc.new{ User.current.auth_source_id? }
  menu :top_menu, :colleagues, {:controller => :colleagues, :action => :index}, :caption => :colleagues_title, :if => Proc.new{ User.current.auth_source_id? }
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
