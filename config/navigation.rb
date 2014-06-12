# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  
  # Render Bootstrap
  navigation.renderer = SimpleNavigationRenderers::Bootstrap3
  

  # Navigation
  navigation.items do |primary|
    primary.item :home, 'Home', root_path
    
    primary.item :database, 'Database' do |sub_nav|
      sub_nav.item :artifacts, { icon: 'glyphicon glyphicon-glass', text: 'Artifacts' }, artifacts_path, :highlights_on => :subpath
      #sub_nav.item :people, { icon: 'glyphicon glyphicon-user', text: 'People' }, people_path, :highlights_on => :subpath
      #sub_nav.item :places, { icon: 'glyphicon glyphicon-map-marker', text: 'Places' }, places_path, :highlights_on => :subpath
      #sub_nav.item :sources, { icon: 'glyphicon glyphicon-book', text: 'Sources' }, sources_path, :highlights_on => :subpath
    end
    
    primary.dom_class = 'nav'
  end
end
