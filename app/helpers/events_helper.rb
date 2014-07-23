module EventsHelper
  
  def currencies
    Money::Currency.table.values.sort{|a,b| a[:priority]<=>b[:priority] }.map{|c| c[:iso_code]}
  end
  
  
  def actors_span(actors)
    icons = {"Unknown"=>"question-sign", "Person"=> "user", "Place"=> "map-marker", "Location"=> "map-marker"}
    actors = actors.map do |a|
      content_tag(:span, nil, class: "glyphicon glyphicon-#{icons[a.class.to_s]}") + " " + a.name
    end
    actors.join(", ").html_safe
  end
  
end
