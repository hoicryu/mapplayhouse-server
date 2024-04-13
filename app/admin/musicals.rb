ActiveAdmin.register Musical do
  menu parent: "뮤지컬"

  filter :title

  index do
    id_column
    column :title
    column :body
    column :_type do |musical| I18n.t("enum.musical._type.#{musical._type}") end
    column :image do |musical| image_tag(musical.image_path, class: "admin-show-image") end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :body
      row :_type do |musical| I18n.t("enum.musical._type.#{musical._type}") end
      row :image do |musical| image_tag(musical.image_path, class: "admin-show-image") end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
      f.input :_type, as: :select, collection: Musical.enum_selectors(:_type)
      f.inputs "상품이미지", :multipart => true do
        f.input :image, :as => :file, input_html: {class: "item-image"}, :hint => f.object.image.present? \
        ? image_tag(f.object.image.url, class: "")
        : content_tag(:span, "No Image Yet")
        f.input :image_cache, :as => :hidden
      end
    end
    f.actions
  end
end