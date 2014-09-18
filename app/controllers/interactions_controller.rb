class InteractionsController < ApplicationController
  
  def show
    @interaction = Interaction.find(params[:id])
    redirect_to @interaction.event
  end
  
end
