module UUID
  extend ActiveSupport::Concern
  
  
  included do
    
    # Generate a UUID on create
    after_create do |model|
      if !model.uuid
        model.uuid = SecureRandom.uuid
      end
    end
  
    # Proper REST routing
    def to_param
      uuid
    end
    
  end
end