class Event < ApplicationRecord
    validates :start_date, presence: true
    validates :duration, presence: true
    validates :title, presence: true, length: {in:5..140}
    validates :description, presence: true, length: {in:20..1000}
    validates :price, presence: true
    validates :location, presence: true
    validate :start_must_be_after_current_time
    validate :duration_must_be_positive
    validate :price_must_be_between_1_1000

    has_many :attendances, dependent: :delete_all
    has_many :users, through: :attendance
    belongs_to :admin, class_name: 'User' 
    
    def start_must_be_after_current_time
        errors.add(:start_date, "Start date cannot be before the current date") unless
        start_date > Date.today
    end

    def duration_must_be_positive
        errors.add(:duration, "Duration cannot be negative") unless
        duration > 0
    end 

    def price_must_be_between_1_1000
        errors.add(:price, "Price must be between 1 and 1000") unless
        price >= 1
        price <= 1000
    end
end
