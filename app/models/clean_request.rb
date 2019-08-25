class CleanRequest < ApplicationRecord
    EMPLOYEES = Employee.where(status: 1)
    belongs_to :user

end
