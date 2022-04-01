module ActsAsRailable
  module Interval
    extend ActiveSupport::Concern

    included do
      #  database:  local date
      # parameter:  local date
      scope :date_field_interval, -> (field, d1, d2) {
        tname = self.table_name
        if d1.present? and d2.present?
          where("#{tname}.#{field} >= ?", d1).where("#{tname}.#{field} <= ?", d2)
        elsif d1.present?
          where("#{tname}.#{field} >= ?", d1)
        elsif d2.present?
          where("#{tname}.#{field} <= ?", d2)
        end
      }

      #  database:  time
      # parameter:  utc/local time
      scope :time_field_interval, -> (field, t1, t2) {
        tname = self.table_name
        if t1.present? and t2.present?
          where("#{tname}.#{field} >= ?", t1).where("#{tname}.#{field} <= ?", t2)
        elsif t1.present?
          where("#{tname}.#{field} >= ?", t1)
        elsif t2.present?
          where("#{tname}.#{field} <= ?", t2)
        end
      }

      #  database:  time
      # parameter:  utc time
      scope :utc_field_interval, -> (field, t1, t2) {
        time_field_interval(field, t1, t2)
      }

      #  database:  utc time
      # parameter:  local date
      scope :local_field_interval, -> (field, d1, d2) {
        t1 = d1.to_time.beginning_of_day if d1.present?
        t2 = d2.to_time.end_of_day if d2.present?
        time_field_interval(field, t1, t2)
      }
    end
  end
end
