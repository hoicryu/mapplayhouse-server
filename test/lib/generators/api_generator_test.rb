require "test_helper"
require "generators/api/api_generator"

class ApiGeneratorTest < Rails::Generators::TestCase
  tests ApiGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
