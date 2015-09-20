# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

roles = ["Admin","Editor", "Author", "Member", "Creative", "Moderator"]

roles.each do |role|
  Role.create!({ name: role })
end

pages = ["News", "Sports", "OpEd", "Arts", "Capstone"]

pages.each do |page|
  Page.create!({ name: page })
end
