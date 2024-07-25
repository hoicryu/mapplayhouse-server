ActiveAdmin.register UserGroup do
  menu parent: "참여"

  filter :user
  filter :group

  index do
    id_column
    column :group do |user_group|
      title = user_group.group.title + ' ' + user_group.group.musical.title
      title
    end
    column :user
    column :part
    column :status do |user_group| I18n.t("enum.user_group.status.#{user_group.status}") end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :group do |user_group|
        title = user_group.group.title + ' ' + user_group.group.musical.title
        title
      end
      row :user
      row :part
      row :status do |user_group| I18n.t("enum.user_group.status.#{user_group.status}") end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :group, as: :select, collection: Group.all.map {|g| [g.title + ' ' + g.musical.title, g.id ]}, input_html: { id: 'user_group_input' }
      f.input :user
      f.input :part, as: :select, collection: Part.all.map {|part| [part.musical.title + ' ' + part.title, part.id ]}
      f.input :status, as: :select, collection: UserGroup.enum_selectors(:status)
    end
    f.actions
  end

end