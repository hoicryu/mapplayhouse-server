ActiveAdmin.register TimeList do
  menu parent: "사이트"

  index do
    id_column
    column "시작 시간" do |time|
      time.start_at.strftime("%H:%M:%S")
    end
    column "종료 시간" do |time|
      time.end_at.strftime("%H:%M:%S")
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row "시작 시간" do |time|
        time.start_at.strftime("%H:%M:%S")
      end
      row "종료 시간" do |time|
        time.end_at.strftime("%H:%M:%S")
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :start_at, :as => :time_picker
      f.input :end_at, :as => :time_picker
    end
    f.actions
  end
end