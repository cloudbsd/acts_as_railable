class Post < ApplicationRecord
  # constants
  CURRENCIES = %w( CNY USD EUR GBP JPY )

  # enums
  enum status: { edited: 0, published: 1, approved: 2, trashed: 3 }
end
