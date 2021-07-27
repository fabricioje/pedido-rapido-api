json.employees do
  json.array! @loading_service.records, :id, :name, :occupation, :nickname, :email
end

json.meta do
  json.partial! 'shared/pagination', pagination: @loading_service.pagination
end
