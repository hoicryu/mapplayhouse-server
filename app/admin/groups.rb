ActiveAdmin.register Group do
  menu parent: "참여"

  filter :title

  controller do
    def create
      if params.dig(:group, :images)
        image_array = params.dig(:group, :images)
        images_attributes = params.dig(:group, :images_attributes)
        params[:group].delete :images
        params[:group].delete :images_attributes
      end

      create! do |format|
        Image.where(id: image_array.split(",")).update_all(imagable_id: resource.id)
        resource.update({images_attributes: images_attributes}) if images_attributes.present?
        format.html { redirect_to admin_group_path(resource.id) }
      end
    end

    def update
      params[:group].delete(:images) if params.dig(:group, :images)
      params[:group].delete(:images_attributes) if params.dig(:group, :images_attributes)
      super
    end
  end


  collection_action :dropzone, method: :post do
    if params[:image].present?
      image = Image.create!(
        image: params[:image],
        imagable_type: params[:imagable_type],
        imagable_id: params[:imagable_id],
      )
      render json: image.id
    end
  end

  collection_action :image_destroy, method: :delete do
    image = Image.find(params[:image_id])
    image.destroy if current_admin_user.present?
  end



  index do
    id_column
    column :title
    column :musical_alias
    column :musical do |group| 
      musical = group.musical
      link_to(musical.title, admin_musical_path(musical.id))
    end
    column :status do |group| I18n.t("enum.group.status.#{group.status}") end
    column :audition_date
    column :submit_start_at
    column :submit_end_at
    column :performance_start_at
    column :course_start_at
    column :application_link
    column :concert_hall
    actions
  end

  show do
    attributes_table do
      row :id
      row :musical_alias
      row :musical do |group| 
        musical = group.musical
        link_to(musical.title, admin_musical_path(musical.id))
      end
      row :title
      row :status do |group| I18n.t("enum.group.status.#{group.status}") end
      row :audition_date
      row :submit_start_at
      row :submit_end_at
      row :performance_start_at
      row :performance_end_at
      row :course_start_at
      row :application_link
      row :concert_hall
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :musical_alias
      f.input :musical, as: :select, collection: Musical.all.map {|c| [c.title, c.id]}
      f.input :status, as: :select, collection: Group.enum_selectors(:status)
      f.input :audition_date, as: :date_time_picker
      f.input :submit_start_at, as: :date_time_picker
      f.input :submit_end_at, as: :date_time_picker
      f.input :performance_start_at, as: :date_time_picker
      f.input :performance_end_at, as: :date_time_picker
      f.input :course_start_at, as: :date_time_picker
      f.input :application_link
      f.input :concert_hall
      panel '이미지', class: "description-panel" do
        render 'admin/groups/dropzone', f: f
      end
    end
    f.actions
  end
end