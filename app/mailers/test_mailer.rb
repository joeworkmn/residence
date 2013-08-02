class TestMailer < ActionMailer::Base
   default from: ENV["RESIDENCE_MAILER_USERNAME"] + "@gmail.com"


   def test_email
      mail to: "joeworkmn@gmail.com", subject: "test from action mailer"
   end
end
