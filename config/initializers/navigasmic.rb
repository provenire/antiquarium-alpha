Navigasmic.setup do |config|
  
  # Primary Nav
  config.semantic_navigation :primary do |n|
    n.item 'Home', controller: 'home'
    
    n.group 'Database' do
      n.item '<span class="glyphicon glyphicon-glass"></span> Artifacts',   controller: 'artifacts'
      n.item '<span class="glyphicon glyphicon-user"></span> People',       controller: 'people'
      n.item '<span class="glyphicon glyphicon-map-marker"></span> Places', controller: 'places'
      n.item '<span class="glyphicon glyphicon-book"></span> Sources',      controller: 'sources'
    end
    
    # n.group 'Workflows' do
    #   n.item 'Website', controller: 'workflows', action: 'website'
    # end
  end
  

  # Bootstrap Top Nav Builder
  config.builder bootstrap: Navigasmic::Builder::ListBuilder do |builder|
    builder.wrapper_class    = 'nav navbar-nav'
    builder.has_nested_class = 'dropdown'
    builder.is_nested_class  = 'dropdown-menu'

    builder.label_generator = proc do |label, options, has_link, has_nested|
      if !has_nested || has_link
        "<span>#{label}</span>"
      else
        link_to("#{label} <b class='caret'></b>".html_safe, '#', class: 'dropdown-toggle', data: {toggle: 'dropdown'})
      end
    end

    builder.link_generator = proc do |label, link, link_options, has_nested|
      if has_nested
        link = '#'
        label << "<b class='caret'></b>"
        link_options.merge!(class: 'dropdown-toggle', data: {toggle: 'dropdown'})
      end
      link_to(label, link, link_options)
    end
  end

end
