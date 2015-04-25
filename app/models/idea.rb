class Idea < ActiveRecord::Base

  #associations
  belongs_to :user
  has_many :comments, dependent: :destroy

  #validations
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

end
