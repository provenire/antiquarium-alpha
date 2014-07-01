require 'test_helper'

class ArtifactTest < ActiveSupport::TestCase
  
  test "uuid generated on create" do
    a = Artifact.create(name: 'test artifact')
    assert_match /^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i, a.uuid
  end
  
  
  test "should not save without name" do
    a = Artifact.new
    assert_raises ActiveRecord::StatementInvalid do
      a.save
    end
  end
  
  
  test "should not save artifact with empty string name" do
    a = Artifact.new(name: "")
    assert_not a.save
  end
  
end
