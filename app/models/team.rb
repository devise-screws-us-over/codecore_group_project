class Team < ActiveRecord::Base
  belongs_to :owner, class: User, foreign_key: :owner
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :shares, dependent: :destroy
  has_many :shared_ideas, through: :shares, source: :idea

  has_many :memberships, dependent: :destroy
  has_many :member_users, through: :memberships, source: :user

  def most_popular
    shared_ideas.includes(:comments).order('created_at DESC')
  end

end
