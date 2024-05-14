ActiveAdmin.register Rating do
  menu parent: "뮤지컬"

  filter :title

  index do
    id_column
    column :title
    column :price
    column :status do |rating| rating.enum_ko(:status) end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :price
      row :status do |rating| rating.enum_ko(:status) end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :price
      f.input :status, as: :select, collection: Rating.enum_selectors(:status)
    end
    f.actions
  end
end