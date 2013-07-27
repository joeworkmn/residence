class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end


FactoryGirl.define do
   factory :apartment do
      sequence(:number)  { |n| n }
      password               'password'
      password_confirmation  'password'

      ignore do
         occupied           true
         status_start_date  { Time.now }
         number_of_tenants  5
         comment            { Faker::Lorem.sentence(10) }

         tenants_count  0
         tickets_count  0
      end

      status do
         build(:apartment_status, 
               occupied: occupied, 
               status_start_date: status_start_date, 
               number_of_tenants: number_of_tenants, 
               comment: comment)
      end

      after(:create) do |apt, eval|
         if eval.tenants_count > 0
            FactoryGirl.create_list(:tenant, eval.tenants_count, apartment: apt)
         end
         if eval.tickets_count > 0
            FactoryGirl.create_list(:ticket, eval.tickets_count, apartment: apt)
         end
      end

   end


   # Defining attributes in apartment factory.
   factory :apartment_status do
   end


   factory :user do
      fname             { Faker::Name.first_name          }
      lname             { Faker::Name.last_name           }
      email             { Faker::Internet.email           }
      phone_primary     { Faker::PhoneNumber.phone_number }
      phone_secondary   { Faker::PhoneNumber.phone_number }

      factory :tenant, :class => Tenant do
         apartment
      end

      factory :staff, :class => Staff do
         sequence(:username)     { |n| "user#{n}" }   
         password                "password"
         password_confirmation   "password"

         factory :manager do
            roles         ['manager']
            current_role  'manager'
         end

         factory :guard do
            roles         ['guard']
            current_role  'guard'
         end
      end
   end

   factory :ticket do
      description  { Faker::Lorem.sentence(10) }

      violations do
         viols = []
         rand(1..3).times { viols << build(:violation) }
         viols
      end

      apartment
      association :staff, :factory => :guard
   end


   factory :violation do
      sequence(:name)  { |n| "violation-#{n}" }
      fine { rand(1..10).to_d }
   end


   factory :schedule do
      month            "July"
      year             2013
      month_position   7
      interval_length  7

      factory :schedule_with_entries do

         ignore do
            entries_count 3
         end

         after(:create) do |schedule, eval|
            FactoryGirl.create_list(:schedule_entry, eval.entries_count, schedule: schedule)
         end
      end
   end



   factory :schedule_entry do
      date                { Date.today }
      day_or_night        'day'

      shift
      association :staff, :factory => :guard
   end



   factory :schedule_configuration do
      default_interval_length  7
   end

   factory :shift do
      sequence(:name)  { |n| "shift-#{n}" }
   end
   
end
