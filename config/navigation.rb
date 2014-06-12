# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  
  # Render Bootstrap
  navigation.renderer = SimpleNavigationRenderers::Bootstrap3

  # Navigation
  navigation.items do |primary|
    primary.item :home, 'Home', root_path
    
    primary.dom_class = 'nav'
  end
end
