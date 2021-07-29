# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin=User.new({ email: "admin@gmail.com", name: "admin", admin: true, password: "password"})
    
    admin.toggle!(:admin)

    if admin.valid?
      admin.save()

    elsif admin.errors.any?
      admin.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "****NOT VALID****"
    end