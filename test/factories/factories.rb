# To use in rails console, require 'factory_girl_rails'
FactoryGirl.define do
   # Hard code method
   factory :apartment do
      number             101

      #factory :user_with_checkbooks do
      #   ignore do
      #      checkbook_count 10
      #   end

      #   after(:create) do |user, evaluator|
      #      FactoryGirl.create_list(:checkbook, evaluator.checkbook_count, owner: user)
      #   end
      #end
   end

   factory :apartment_status do
      occupied           true
      status_start_date  Time.now
      number_of_tenants  5

      apartment
   end

   #factory :checkbook do
   #   sequence(:name) { |n| "Test Checkbook #{n}" }

   #   association :owner, factory: :user
   #end


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
   
   # Each time FactoryGirl.create(:user) is used, the sequence block
   # variable is incremented. So first time the user's fname will be
   # Person_1, then Person_2, and so on.
   #factory :user do
   #   sequence(:fname) { |n| "Person_#{n}" }
   #   sequence(:lname) { |n| "Person_#{n}" }
   #   sequence(:username) { |n| "person#{n}" }
   #   password              "password"
   #   password_confirmation "password"
   #end
   
end
