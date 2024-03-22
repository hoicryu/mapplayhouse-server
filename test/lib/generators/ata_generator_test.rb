require "test_helper"
require "generators/ata/ata_generator"

class AtaGeneratorTest < Rails::Generators::TestCase
  tests AtaGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
