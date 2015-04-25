class User < ActiveRecord::Base

  has_secure_password

  attr_accessor :avatar_url

  has_many :ideas, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :pins, dependent: :destroy
  has_many :pinned_ideas, through: :pins, source: :idea

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships, source: :team

  has_one :profile, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, 
                              :on => :create

  def full_name
    ("#{first_name} #{last_name}").strip
  end

end
