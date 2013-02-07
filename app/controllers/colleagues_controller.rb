class ColleaguesController < ApplicationController
  unloadable

  helper :custom_fields
  include CustomFieldsHelper

  def index
    @project = if params[:project_id].present?
      Project.find_by_identifier(params[:project_id])
    end

    @memberships = Member.find(:all, :conditions => {:user_id => User.current.id})

    @colleagues = User.active.from_project(@project).like(params[:name])
    @colleagues = @colleagues.in_group(params[:group_id]) if params[:group_id].present?
    if params[:custom_field].present?
      params[:custom_field].each do |key, value|
        @colleagues = @colleagues.like_custom_field(key, value)
      end
    end
    @colleagues = @colleagues.find(:all, :conditions => {:auth_source_id => User.current.auth_source_id}, :order => "lastname, firstname")

    render :action => params[:view] == "list" ? :list : :index
  end
end
