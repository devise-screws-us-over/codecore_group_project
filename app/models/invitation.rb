class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :recipient, uniqueness: {message: "- One (or more) of your email addresss is already on invitation list."}
  validates_format_of :recipient, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, 
                              :on => :create
end
