ActiveAdmin.register Part do
  menu parent: "뮤지컬"

  filter :title

  index do
    id_column
    column :musical do |part| 
      musical = part.musical
      link_to(musical.title, admin_musical_path(musical.id))
    end
    column :rating do |part| 
      rating = part.rating
      link_to(rating.title, admin_rating_path(rating.id))
    end
    column :title
    column :image do |part| image_tag(part.image_path) end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :musical do |part| 
        musical = part.musical
        link_to(musical.title, admin_musical_path(musical.id))
      end
      row :rating do |part| 
        rating = part.rating
        link_to(rating.title, admin_rating_path(rating.id))
      end
      row :image do |part| image_tag(part.image_path, class: "cover-image") end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :musical, as: :select, collection: Musical.all.map {|c| [c.title, c.id]}
      f.input :rating, as: :select, collection: Rating.all.map {|c| [c.title, c.id]}
      f.inputs "이미지", :multipart => true do
        f.input :image, :as => :file, input_html: {class: "cover-image"}, :hint => f.object.image.present? \
        ? image_tag(f.object.image.url, class: "")
        : content_tag(:span, "No Image Yet")
        f.input :image_cache, :as => :hidden
      end
      render 'admin/parts/image_reader'
    end
    f.actions
  end
end