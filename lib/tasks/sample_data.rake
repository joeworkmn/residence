namespace :db do
   desc "Fill database with sample data"
   task make_tickets: :environment do
      make_tickets
   end
end

def make_tickets
   timmy = Staff.find_by(username: 'timmy')
   apt_nums = [101, 102].join(',')
   apartment_ids = Apartment.where("number IN (#{apt_nums})").pluck(:id)

   20.times do |n|
      ticket = timmy.tickets.build
      ticket.apartment_id = apartment_ids.sample
      ticket.description = Faker::Lorem.sentence(10)
      viols = Violation.all
      ticket.violations = viols.sample(rand(1..viols.size))

      ticket.save
   end
end
