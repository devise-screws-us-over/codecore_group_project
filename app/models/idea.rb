class Idea < ActiveRecord::Base

  #associations
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :pins, dependent: :destroy
  has_many :users_pinned, through: :pins, source: :user

  has_many :shares, dependent: :destroy
  has_many :teams, through: :shares, source: :team

  #validations
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  def mk_title
    markdown title
  end

  def mk_body
    markdown body
  end
end
