ActiveAdmin.register ApplicationForm do
  menu parent: "참여"

  actions :all, except: [:edit, :update, :destroy, :new, :create]

  filter :title

  index do
    id_column
    column :user do |application|
      user = application.user
      link_to(user.name, admin_user_path(user.id))
    end
    column :group do |application| 
      group = application.group
      link_to("#{group.title} (#{group.musical.title})", admin_group_path(group.id))
    end
    column :name
    column :birthday
    column :phone
    column :part_ids do |application| 
      Part.where(id: application.part_ids).map { |part| part.title }.join(", ")
    end
    column :signature
    actions
  end

  show do
    attributes_table do
      row :user do |application|
        user = application.user
        link_to(user.name, admin_user_path(user.id))
      end
      row :select do |application| 
        group = application.group
        link_to("#{group.title} (#{group.musical.title})", admin_group_path(group.id))
      end
      row :name
      row :birthday
      row :phone
      row :part_ids do |application| 
        Part.where(id: application.part_ids).map { |part| part.title }.join(", ")
      end
      row :signature
      row :created_at
      row :updated_at
    end
  end

end