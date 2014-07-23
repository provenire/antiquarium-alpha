module EventsHelper
  
  def currencies
    Money::Currency.table.values.sort{|a,b| a[:priority]<=>b[:priority] }.map{|c| c[:iso_code]}
  end
  
end
