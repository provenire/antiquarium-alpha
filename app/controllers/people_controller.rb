class PeopleController < ApplicationController
  
  def index
    @people = Person.order(:name).page params[:page]
  end
  
  def show
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def create
  end
  
  def destroy
  end
  
end
