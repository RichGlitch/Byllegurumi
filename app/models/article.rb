class Article < ActiveRecord::Base
  belongs_to :user
  validates :titulo, presence: true, length: {minimum: 3, maximum: 50}
  validates :patron, presence: true, length: {minimum: 10, maximum: 5000}
  validates :subtitulo, presence: true, length: {minimum: 3, maximum: 50}
  validates :user_id, presence: true
end