class ChangeApartmentNumberType < ActiveRecord::Migration
  def change
     execute("alter table apartments alter column number type integer using cast(number as integer)")
  end
end
