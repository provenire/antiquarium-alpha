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
    redirect_to @person if @person.save
  end
  
  def edit
  end
  
  def create
  end
  
  def destroy
  end
  
  
  # Params
  private

  def person_params
    params.require(:person).permit(:name, :description, :gender, :date_of_birth, :date_of_birth, :nationality)
  end
  
end
