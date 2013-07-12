# == Schema Information
#
# Table name: shifts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Shift < ActiveRecord::Base
end
