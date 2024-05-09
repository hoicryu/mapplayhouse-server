ActiveAdmin.register Rating do
  menu parent: "뮤지컬"

  filter :title

  index do
    id_column
    column :title
    column :price
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :price
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :price
    end
    f.actions
  end
end