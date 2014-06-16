class PeopleController < ApplicationController
  
  def index
    @people = Person.order(:name).page params[:page]
  end
  
  def show
  end
  
  def new
    @person = Person.new
  end
  
  def create
    person = Person.new(person_params)
    if person.save
      redirect_to person
    end
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
