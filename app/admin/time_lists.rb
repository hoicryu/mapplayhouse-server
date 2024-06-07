ActiveAdmin.register TimeList do
  menu parent: "사이트"

  index do
    id_column
    column :start_at
    column :end_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :start_at
      row :end_at
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :start_at
      f.input :end_at
    end
    f.actions
  end
end