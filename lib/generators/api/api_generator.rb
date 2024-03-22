class ApiGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def generate_controller
    template "controller.rb", "app/controllers/#{name.pluralize}_controller.rb"
    template "test.rb", "test/controllers/#{name.pluralize}_controller_test.rb"
  end

  private

  def api_name
    name.pluralize.split("/").map(&:capitalize).join("::").split("::").map { |str| str.split("_").map(&:capitalize).join }.join("::")
  end

  def version
    name.include?("/") ? "#{name.split('/').first.upcase}::" : ""
  end
end
