# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

roles = ["Admin", "Author", "Member", "Creative", "Moderator"]

while !roles.empty?
  r = Role.new
  r.name = roles.shift()
  r.save
end

pages = ["News", "Sports", "OpEd", "Arts", "Capstone"]

while !pages.empty?
  p = Page.new
  p.name = pages.shift()
  p.save
end
