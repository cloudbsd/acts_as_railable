class ApplicationRecord < ActiveRecord::Base
  include ActsAsRailable::Humanable
  include ActsAsRailable::Interval

  primary_abstract_class
end
