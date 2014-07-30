class PeopleController < ApplicationController
  
  def index
    @people = Person.order(:name).page params[:page]
  end
  
  def show
    @person = Person.find_by_uuid!(params[:id])
  end
  
  def new
    @person = Person.new
  end
  
  def create
    @person = Person.new(person_params)
    
    # Redirect
    if @person.save
      redirect_to @person
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    @person = Person.find_by_uuid(params[:id])
    @person.update_attributes(params[:name] => params[:value])
    render nothing: true
  end
  
  def destroy
  end
  
  
  def history
    @person = Person.find_by_uuid!(params[:id])
    @versions = @person.versions.each{|v| v.whodunnit = User.find(v.whodunnit.to_i); v.changeset.delete(:updated_at) }
    @versions.sort!{|a,b| b.created_at <=> a.created_at }
  end
  
  
  def find
    query = params[:q]
    results = PgSearch.multisearch(query).where(searchable_type: ['Person'])
    respond_to do |format|
      format.json {
        render :json => results.map{|a| 
          {
            id:    a.searchable.uuid,
            text:  a.searchable.name
          }
        }
      }
    end
  end
    
  
  
  # Params
  private

  def person_params
    params.require(:person).permit(:name, :description, :gender, :date_of_birth, :date_of_birth, :nationality)
  end
  
end
