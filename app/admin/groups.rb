ActiveAdmin.register Group do
  menu parent: "참여"

  filter :title

  index do
    id_column
    column :title
    column :musical do |group| 
      musical = group.musical
      link_to(musical.title, admin_musical_path(musical.id))
    end
    column :status do |group| I18n.t("enum.group.status.#{group.status}") end
    column :audition_date
    column :submit_start_at
    column :submit_end_at
    column :performance_date
    actions
  end

  show do
    attributes_table do
      row :id
      row :musical do |group| 
        musical = group.musical
        link_to(musical.title, admin_musical_path(musical.id))
      end
      row :title
      row :status do |group| I18n.t("enum.group.status.#{group.status}") end
      row :audition_date
      row :submit_start_at
      row :submit_end_at
      row :performance_date
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :musical, as: :select, collection: Musical.all.map {|c| [c.title, c.id]}
      f.input :status, as: :select, collection: Group.enum_selectors(:status)
      f.input :audition_date, as: :date_time_picker
      f.input :submit_start_at, as: :date_time_picker
      f.input :submit_end_at, as: :date_time_picker
      f.input :performance_date, as: :date_time_picker
    end
    f.actions
  end
end