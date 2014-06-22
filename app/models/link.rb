class Link < ActiveRecord::Base

	belongs_to :user

	validates :url, presence: true
	validates_format_of :url, :with => URI::regexp(%w(http https)), message: "must include http or https."
	
end
