require_relative 'staff.rb'


enter_new_staff = Staff.create_new
Staff.add_to_staff_csv(enter_new_staff)