class Roadmap::Milestone
  
  attr_accessor :issues
  attr_reader :raw, :number, :state, :title, :description, :due_on
  
  def initialize(raw)
    @raw = raw
    @number      = @raw.number
    @state       = @raw.state
    @title       = @raw.title
    @description = @raw.description
    @due_on      = @raw.due_on
    
    @issues = []
  end
  
  def sort!
    @issues.sort_by!(&:number)
  end
  
end