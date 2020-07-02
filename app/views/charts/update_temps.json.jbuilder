#https://github.com/rails/jbuilder
unless @temp.nil? && @created_at.nil?
  json.temp @temp
  json.created_at @created_at
end