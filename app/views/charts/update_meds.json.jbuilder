#https://github.com/rails/jbuilder
unless @averages.nil?
  json.meds @averages, :temp, :giorno
end
