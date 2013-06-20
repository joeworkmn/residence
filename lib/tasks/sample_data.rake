namespace :db do
   desc "Fill database with sample data"
   task make_tickets: :environment do
      make_tickets
   end
end

def make_tickets
   timmy = Staff.find_by(username: 'timmy')
   20.times do |n|
      apt_nums = [101, 102].join(',')
      apartment_ids = Apartment.where("number IN (#{apt_nums})").pluck(:id)

      ticket = timmy.tickets.build
      ticket.apartment_id = apartment_ids.sample
      ticket.description = Faker::Lorem.sentence(10)
      viols = Violation.all
      ticket.violations = viols.sample(rand(1..viols.size))
      ticket.total_fine = ticket.violations.map { |v| v.fine }.inject(:+)

      ticket.save
   end
end
