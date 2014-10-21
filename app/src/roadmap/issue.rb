class Roadmap::Issue
  
  attr_reader :raw, :number, :state, :title, :body, :labels, :milestone
  
  def initialize(raw)
    @raw    = raw
    @number = @raw.number
    @state  = @raw.state
    @title  = @raw.title
    @body   = @raw.body
    @labels = @raw.labels.map{|l| l.delete(:url); l }
    @milestone = @raw.milestone.title unless @raw.milestone.nil?
  end
  
  def open?
    @state == 'open'
  end
  
  def closed?
    @state == 'closed'
  end
  
end