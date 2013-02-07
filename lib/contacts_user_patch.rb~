require_dependency 'principal'
require_dependency 'user'

module ColleaguesPlugin
  module UserPatch
    def self.included(base)
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable

        if Rails::VERSION::MAJOR < 3
          named_scope :from_project, lambda { |project|
            if project.present?
              { :conditions => ["#{User.table_name}.id IN (SELECT #{Member.table_name}.user_id FROM #{Member.table_name} WHERE #{Member.table_name}.project_id = ?)", project.id] }
            end
          }

          named_scope :like_custom_field, lambda{ |custom_field_id, q|
            if q.present? && custom_field_id.present?
              {
                :conditions => ["custom_values.custom_field_id = ? AND users.id = custom_values.customized_id AND custom_values.value LIKE ?", custom_field_id, "%#{q}%"],
                :include => :custom_values
              }
            end
          }
        else
          scope :from_project, lambda { |project|
            if project.present?
              { :conditions => ["#{User.table_name}.id IN (SELECT #{Member.table_name}.user_id FROM #{Member.table_name} WHERE #{Member.table_name}.project_id = ?)", project.id] }
            end
          }

          scope :like_custom_field, lambda{ |custom_field_id, q|
            if q.present? && custom_field_id.present?
              {
                :conditions => ["custom_values.custom_field_id = ? AND users.id = custom_values.customized_id AND custom_values.value LIKE ?", custom_field_id, "%#{q}%"],
                :include => :custom_values
              }
            end
          }
        end
      end
    end

    module ClassMethods
    end

    module InstanceMethods
    end
  end
end
