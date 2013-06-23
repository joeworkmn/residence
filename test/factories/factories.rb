class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end


FactoryGirl.define do
   factory :apartment do
      number                 101
      password               'password'
      password_confirmation  'password'

      # status attrs.
      ignore do
         occupied           true
         status_start_date  { Time.now }
         number_of_tenants  5
         comment            Faker::Lorem.sentence(10)
      end

      status do
         build(:apartment_status, 
               occupied: occupied, 
               status_start_date: status_start_date, 
               number_of_tenants: number_of_tenants, 
               comment: comment)
      end

      factory :apartment_with_tenants do
         ignore do
            tenants_count 3
         end

         after(:create) do |apt, eval|
            FactoryGirl.create_list(:tenant, eval.tenants_count, apartment: apt)
         end

      end
   end


   # Defining attributes in apartment factory.
   factory :apartment_status do
   end


   factory :tenant do
      fname             Faker::Name.first_name
      lname             Faker::Name.last_name
      email             Faker::Internet.email
      phone_primary     Faker::PhoneNumber.phone_number
      phone_secondary   Faker::PhoneNumber.phone_number

      apartment
   end

   #factory :entry do
   #   check_num           "1"
   #   date                "2013/1/1"
   #   description         "some description"
   #   amount              "2.00"
   #   transaction_type    "withdrawal"

   #   checkbook # This line says that this entry is associated with a checkbook. 
   #             # Then I can create this entry in tests using 
   #             # FactoryGirl.create(:entry, checkbook: @checkbook) where @checkbook is defined in the test
   #end
   
end
