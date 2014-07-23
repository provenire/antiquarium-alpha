class Verb < ActiveRecord::Base
  def display
    self[:display]
  end
end
