Navigasmic.setup do |config|
  
  # Primary Nav
  config.semantic_navigation :primary do |n|
    n.item 'Home', controller: 'home', action: 'index', highlights_on: Proc.new{ current_page?(root_path) }
    
    n.group 'Database' do
      n.item '<span class="glyphicon glyphicon-glass"></span> Artifacts',   controller: 'artifacts'
      n.item '<span class="glyphicon glyphicon-user"></span> People',       controller: 'people'
      n.item '<span class="glyphicon glyphicon-map-marker"></span> Places', controller: 'places'
      n.item '<span class="glyphicon glyphicon-book"></span> Sources',      controller: 'sources'
    end
    
    n.item 'Tasks',   controller: 'home', action: 'tasks',   highlights_on: '/tasks'
    n.item 'Roadmap', controller: 'home', action: 'roadmap', highlights_on: '/roadmap'
    
    # n.group 'Workflows' do
    #   n.item 'Website', controller: 'workflows', action: 'website'
    # end
  end
  
  
  # User Nav
  config.semantic_navigation :user do |n|
    n.item 'Admin', '/admin', hidden_unless: Proc.new{ current_user.admin? }
    
    n.group Proc.new{ current_user.name } do
      n.item '<span class="glyphicon glyphicon-user"></span> Profile', '/profile', highlights_on: Proc.new{ current_page?(current_user) }
      n.item '<span class="glyphicon glyphicon-cog"></span> Settings', '/settings'
      n.item '<li class="divider"></li>'
      n.item '<span class="glyphicon glyphicon-log-out"></span> Logout', '/sign_out'
    end
  end
  
  
  # User Profile Nav
  # config.semantic_navigation :settings do |n|
  #   n.item '<span class="glyphicon glyphicon-user"></span> Activity', controller: 'users', action: 'show', id: Proc.new{ @user.id.to_s }
  #
  #   n.item '<li class="dropdown-header">Config</li>', hidden_unless: Proc.new{ @user && @user == current_user }
  #   n.item '<span class="glyphicon glyphicon-cog"></span> Settings', '/settings', hidden_unless: Proc.new{ @user && @user == current_user }
  # end
  

  # Bootstrap Top Nav Builder
  config.builder bootstrap: Navigasmic::Builder::ListBuilder do |builder|
    builder.wrapper_class    = 'nav navbar-nav'
    builder.has_nested_class = 'dropdown'
    builder.is_nested_class  = 'dropdown-menu'

    builder.label_generator = proc do |label, options, has_link, has_nested|
      #label = label.call(current_user.name) if label.is_a? Proc
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
  
  # Bootstrap Sidebar Nav Builder
  config.builder settings: Navigasmic::Builder::ListBuilder do |builder|
    builder.wrapper_class    = 'nav nav-sidebar'
    builder.has_nested_class = 'dropdown'
    builder.is_nested_class  = 'dropdown-menu'

    builder.label_generator = proc do |label, options, has_link, has_nested|
      #label = label.call(current_user.name) if label.is_a? Proc
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
