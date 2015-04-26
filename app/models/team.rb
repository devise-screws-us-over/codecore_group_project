
class Team < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :shares, dependent: :destroy
  has_many :shared_ideas, through: :shares, source: :idea

  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  has_many :invitations, dependent: :destroy
  has_many :invite_senders, through: :invitations, source: :user
end
