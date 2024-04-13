ActiveAdmin.register Notice do
  menu parent: "사이트"
  config.sort_order = "position_asc"
  config.paginate   = false

  filter :title

  reorderable

  index as: :reorderable_table do
    id_column
    column :title
    column :body
    column :position
    column :status
    column :_type
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
      f.input :position
      f.input :status, as: :select, collection: Notice.enum_selectors(:status)
      f.input :_type, as: :select, collection: Notice.enum_selectors(:_type)
    end
    f.actions
  end
end