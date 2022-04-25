class ApplicationRecord < ActiveRecord::Base

  include ActsAsRailable::Humanable

  #
  #  database:  date
  # parameter:  local date
  # scope :date_field_interval, -> (field, d1, d2)

  #  database:  time
  # parameter:  utc/local time
  # scope :time_field_interval, -> (field, t1, t2)

  #  database:  time
  # parameter:  utc time
  # scope :utc_field_interval, -> (field, t1, t2)

  #  database:  utc time
  # parameter:  local date
  # scope :local_field_interval, -> (field, d1, d2)

  include ActsAsRailable::Interval

  include ActsAsRailable::Routable

  primary_abstract_class
end
