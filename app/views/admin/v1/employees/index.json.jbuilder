json.employees do
  json.array! @employees, :id, :name, :occupation, :nickname, :email
end
