class Registration < ActiveRecord::Base
  belongs_to :person
  belongs_to :season
  belongs_to :group
end
