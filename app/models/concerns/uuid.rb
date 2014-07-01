module UUID
  extend ActiveSupport::Concern
  
  
  included do
    
    # Generate a UUID on create
    before_create do |model|
      model.uuid = SecureRandom.uuid
    end
  
    # Proper REST routing
    def to_param
      uuid
    end
    
  end
end