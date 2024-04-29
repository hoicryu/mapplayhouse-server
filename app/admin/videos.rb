ActiveAdmin.register Video do
  menu parent: "사이트"

  filter :title
  filter :group_id

  controller do
    def create
      if params.dig(:video, :youtube_url).present?
        link = params.dig(:video, :youtube_url)
        regexs = [/\S+\/embed\//, /\S+\.be\//]
        if !/\S+\/watch\?v/.match?(link)
          regexs.each do |regex|
            if regex.match?(link)
              changed_link = link.gsub!(link[regex], "")
              params[:video][:youtube_url] = "https://www.youtube.com/watch?v=" + changed_link
            end
          end
        end
      end
      super
    end
  end


  index do
    id_column
    column :group
    column :title
    column :youtube_url
    column :_type do |video| video.enum_ko(:_type) end
    column :show_type do |video| video.enum_ko(:show_type) end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :group
      f.input :title
      f.input :youtube_url
      f.input :_type, as: :select, collection: Video.enum_selectors(:_type)
      f.input :show_type, as: :select, collection: Video.enum_selectors(:show_type)
      f.input :body
    end
    f.actions
  end
end