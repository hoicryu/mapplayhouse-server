ActiveAdmin.register UserGroup do
  menu parent: "참여"

  filter :user
  filter :group

  index do
    id_column
    column :group
    column :user
    column :status do |user_group| I18n.t("enum.user_group.status.#{user_group.status}") end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :group
      row :user
      row :status do |user_group| I18n.t("enum.user_group.status.#{user_group.status}") end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :group
      f.input :user
      f.input :status, as: :select, collection: UserGroup.enum_selectors(:status)
    end
    f.actions
  end
end