class Appointment < ActiveRecord::Base
  belongs_to :user
  validates :start_time, presence: true, uniqueness: { scope: :date }
  validates :end_time, presence: true, uniqueness: { scope: :date }
  validates :date, presence: true
  validates :user, presence: true
  validate :check_for_date_and_time_overlap
  validate :date_is_not_before_today
  validate :end_time_is_after_start

  def check_for_date_and_time_overlap
    days_events = Appointment.where(date: date)
    if days_events.length > 0
      days_events.each do |event|
        if (start_time...end_time).overlaps?(event.start_time...event.end_time)
          errors.add(:time, "overlaps with another appointment")
        end
      end
    end 
  end

  def date_is_not_before_today
    if date && date < Date.today
        errors.add(:date, "is before today")
      end
  end

  def end_time_is_after_start
    if end_time && start_time && end_time < start_time
      errors.add(:end_time, "is invalid")
    end
  end
end