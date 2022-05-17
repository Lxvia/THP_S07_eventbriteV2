class Attendance < ApplicationRecord
    after_create :attendance_email
    belongs_to :user
    belongs_to :event
end
