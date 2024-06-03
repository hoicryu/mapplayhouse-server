ActiveAdmin.register Term do
  menu parent: "사이트"

  filter :title

  index do
    id_column
    column :title
    column :_type do |term| term.enum_ko(:_type) end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :_type do |term| term.enum_ko(:_type) end
      row :check_yes
      row :sub_content
      row :content
    end
  end


  form do |f|
    f.inputs do
      f.input :title
      f.input :_type, as: :select, collection: Term.enum_selectors(:_type)
      f.input :sub_content
      f.input :content
      f.input :check_yes
    end
    f.actions
  end
end