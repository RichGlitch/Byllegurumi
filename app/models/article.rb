class Article < ActiveRecord::Base
  validates :titulo, presence: true, length: {minimum: 3, maximum: 50}
  validates :patron, presence: true, length: {minimum: 10, maximum: 5000}
end