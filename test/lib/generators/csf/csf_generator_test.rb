require 'test_helper'
require 'generators/csf/csf_generator'

module Csf
  class CsfGeneratorTest < Rails::Generators::TestCase
    tests CsfGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
