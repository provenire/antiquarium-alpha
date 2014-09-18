module ActivityHelper
  
  def resource_link(type, id, content)
    resource = type.constantize.find_by_id(id)
    if resource
      link_to(resource.name, resource)
    else
      content_tag('span', content, class: 'text-muted')
    end
  end
  
  def activity_icon(a)
    icons = {
      "created"   => "plus",
      "edited"    => "pencil",
      "destroyed" => "minus"
    }
    icons[activity_action(a)]
  end
  
  def activity_header(a)
    safe_join([activity_owner(a), activity_action(a), activity_article(a), activity_link(a)], ' ')
  end
  
  def activity_owner(a)
    if a.owner
      link_to(a.owner.name, a.owner)
    else
      content_tag('span', a.parameters[:owner_name], class: 'text-muted')
    end
  end
  
  def activity_action(a)
    actions = {
      "create"  => "created",
      "update"  => "edited",
      "destroy" => "destroyed"
    }
    actions[a.key.split('.').second]
  end
  
  def activity_type(a)
    a.trackable_type.downcase
  end
  
  def activity_article(a)
    activity_type(a).indefinite_article
  end
  
  def activity_link(a)
    type = activity_type(a)
    if a.trackable
      link_to(type, a.trackable)
    else
      content_tag('span', type, class: 'text-muted')
    end
  end
  
end
