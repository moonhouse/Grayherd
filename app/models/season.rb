class Season < ActiveRecord::Base
    has_many :registrations
    has_many :groups

  def to_s
    "Season #{start}--#{self.end}"
  end
end
