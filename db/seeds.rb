# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Apartments.
7.times do |f|
   f += 1
   f = f.to_s
   10.times do |a|
      a += 1
      a = a.to_s
      a = (a.length < 2) ? "0#{a}" : a
      apt_num = f + a
      as = ApartmentStatus.new(occupied: false, status_start_date: Time.now)
      Apartment.create(number: apt_num, password: 'password', password_confirmation: 'password', status: as)
   end
end


staff = Staff.create(fname: "John", lname: "Doe", username: 'jdoe', password: 'password', phone_primary: '111-1111', phone_secondary: '111-1112', roles: ['manager'])
Staff.create(fname: "Tim", lname: "Duncan", username: 'timmy', password: 'password', phone_primary: '111-2221', roles: ['guard'])


Violation.create(name: 'Noise')
Violation.create(name: 'Loittering', fine: 5)
Violation.create(name: 'Parking', fine: 7)
