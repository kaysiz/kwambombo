class CleanRequest < ApplicationRecord
    EMPLOYEES = Employee.where(status: 1).order(created_at: :desc)
    belongs_to :user

end
