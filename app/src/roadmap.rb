#require_relative 'roadmap/issue'
#require_relative 'roadmap/milestone'

class Roadmap
  
  attr_reader :raw, :milestones, :issues
  
  def initialize(raw)
    @raw = raw
    parse_issues
    parse_milestones
  end
  
  
  
  private
  
  def parse_issues
    @issues = @raw.map{|i| Issue.new(i)}
  end
  
  def parse_milestones
    milestones = {}
    @raw.select(&:milestone).each do |issue|
      milestones[issue.milestone.id] ||= Roadmap::Milestone.new(issue.milestone)
      milestones[issue.milestone.id].issues << Roadmap::Issue.new(issue)
    end
    @milestones = milestones.values.sort_by(&:title)
    @milestones.each(&:sort!)
  end
  
end