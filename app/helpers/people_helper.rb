module PeopleHelper
  
  # Genders
  def gender_types
    return [
      {:display => 'Male',   :val => 'male'},
      {:display => 'Female', :val => 'female'},
      {:display => 'Unknown', :val => 'unknown'}
    ]
  end
  
end
