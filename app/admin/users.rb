ActiveAdmin.register User do
  menu parent: "사용자"

  scope -> { "전체" }, :all

  filter :name
  filter :email
  filter :phone
  filter :gender

  index do
    selectable_column
    id_column
    column :image do |user| image_tag(user.image_path, class: "admin-index-image") end
    column :name
    column :email
    column :phone
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :phone
      f.input :image
      f.input :gender, as: :select, collection: User.enum_selectors(:gender)
      f.input :accept_sms
      f.input :accept_email
      f.input :description
    end
    f.actions
  end
end
