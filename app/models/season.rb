class Season < ActiveRecord::Base
  has_many :registrations
  has_many :groups
  belongs_to :organization

  def to_s
    "Season #{start}--#{self.end}"
  end

  def as_json(options={})
    { :name => name,
      :deadline => deadline,
      :start => start,
      :end => self.end,
      :id => 1,
      :organization => organization,
      :groups => groups}
  end
end
