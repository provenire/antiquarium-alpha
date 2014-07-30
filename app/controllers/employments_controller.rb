class EmploymentsController < ApplicationController
  
  def show
    @employment = Employment.find(params[:id])
  end
  
  def new
    if params[:place]
      @place = Place.find_by_uuid!(params[:place])
      @employment = Employment.new(place: @place)
    elsif params[:person]
      @person = Person.find_by_uuid!(params[:person])
      @employment = Employment.new(person: @person)
    end
  end
  
  def create
    person = JSON.parse(params[:employment].delete(:person))
    place  = JSON.parse(params[:employment].delete(:place))
    
    @person = Person.find_by_uuid!(person["id"])
    @place  = Place.find_by_uuid(place["id"])
    
    @employment = Employment.new(employment_params)
    @employment.person = @person
    @employment.place  = @place
    
    if @employment.save
      redirect_to @employment
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    @employment = Employment.find(params[:id])
    if params[:name]=='current_job'
      params[:value] = (params[:value]=='true')
    end
    @employment.update_attributes(params[:name] => params[:value])
    render nothing: true
  end
  
  
  def history
    @employment = Employment.find(params[:id])
    @versions = @employment.versions.each{|v| v.whodunnit = User.find(v.whodunnit.to_i); v.changeset.delete(:updated_at) }
    @versions.sort!{|a,b| b.created_at <=> a.created_at }
  end
  
  
  private
  
  def employment_params
    params.require(:employment).permit(:person, :place, :title, :start_date, :end_date, :current_job, :details)
  end
  
end
