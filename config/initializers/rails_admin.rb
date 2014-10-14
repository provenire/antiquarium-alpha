module RailsAdmin::Config::Fields::Types
  class UUID < RailsAdmin::Config::Fields::Base
    RailsAdmin::Config::Fields::Types::register(:uuid, self)

    def allowed_methods
      [@name]
    end

    def dom_name
      @dom_name ||= "#{bindings[:form].object_name}_#{@name}"
    end
  end
end

RailsAdmin.config do |config|
  # Include specific models (exclude the others):
  Rails.application.eager_load!
  config.included_models = ActiveRecord::Base.descendants.map!(&:name)
  
  config.authorize_with do |controller|
    redirect_to main_app.root_path unless current_user.try(:admin?)
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app  
  end
  
  
  config.model 'User' do
    edit do
      group :default do
        field :email
        field :name
        field :password
        field :password_confirmation
        field :role do
          read_only true
        end
      end
    end
  end
  
  
  config.model 'Verb' do
    edit do
      group :default do
        field :display
        field :keyword
        field :components, :enum do
          enum do
            ['date', 'failed', 'details', 'primary_actor', 'secondary_actor', 'price', 'location']
          end
        
          multiple do
            true
          end
        end
      end
    end
  end
  
end
