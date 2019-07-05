class CleanRequest < ApplicationRecord
    EMPLOYEES = Employee.all
    belongs_to :user

end
