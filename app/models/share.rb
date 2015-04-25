class Share < ActiveRecord::Base
  belongs_to :idea
  belongs_to :team
end
