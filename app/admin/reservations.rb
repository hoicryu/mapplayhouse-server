ActiveAdmin.register Reservation do
  menu parent: "연습실"

  filter :user_name_cont, label: "유저 필터"


  index do
    id_column
    column :user
    column :status do |reservation| reservation.enum_ko(:status) end
    column :start_at
    column :end_at
    column :note
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :status do |reservation| reservation.enum_ko(:status) end
      row :start_at
      row :end_at
      row :note
      row :reason_for_rejection
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :status, as: :select, collection: Reservation.enum_selectors(:status)
      f.input :start_at, as: :date_time_picker
      f.input :end_at, as: :date_time_picker
      f.input :note
      f.input :reason_for_rejection
    end
    f.actions
  end
end