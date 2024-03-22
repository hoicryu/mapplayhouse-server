ActiveAdmin.setup do |config|
  config.site_title = "MapPlayHouse"
  config.root_to = "users#index"

  config.before_action do
    params.permit!
  end
  config.comments = false
  config.footer = "MADE WITH HOICRYU"
  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      menu.add label: "사용자", priority: 1
      menu.add label: "상품", priority: 2
      menu.add label: "주문", priority: 3
      menu.add label: "게시물", priority: 4
      menu.add label: "사이트", priority: 5
    end
  end

  meta_tags_options = { viewport: "width=device-width, initial-scale=1" }
  config.meta_tags = meta_tags_options
  config.meta_tags_for_logged_out_pages = meta_tags_options
  config.register_stylesheet "https://use.fontawesome.com/releases/v5.8.1/css/all.css"

  config.authentication_method = :authenticate_admin_user!
  config.on_unauthorized_access = :access_denied
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path
  config.batch_actions = true
  config.localize_format = :long
end
