class Share < ActiveRecord::Base
  belongs_to :idea
  belongs_to :team

  attr_accessor :team_ids

end
