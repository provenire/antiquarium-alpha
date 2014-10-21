class HomeController < ApplicationController
  ANTIQUARIUM_REPO = 'mileszim/antiquarium'
  
  
  def index
    @content    = PageContent.find_by_name('home_page')
    @activities = PublicActivity::Activity.order(created_at: :desc).limit(5)
  end
  
  def roadmap
    @issues = Octokit.list_issues(ANTIQUARIUM_REPO, state: :all)
    @roadmap = Roadmap.new(@issues)
  end
  
end
