class Season < ActiveRecord::Base
    has_many :registrations
    has_many :groups
    belongs_to :organization

  def to_s
    "Season #{start}--#{self.end}"
  end
end
