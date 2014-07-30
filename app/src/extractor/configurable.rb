module Extractor
  module Configurable
    attr_writer :key, :user_agent
    
    class << self
      def keys
        @keys ||= [:key, :user_agent]
      end
    end
    
    def configure
      yield self
      self
    end
    
    
    private
    
    def configuration
      {
        key:        @key,
        user_agent: @user_agent
      }
    end
    
  end
end