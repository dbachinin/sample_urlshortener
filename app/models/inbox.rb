class Inbox < ApplicationRecord
	belongs_to :user
	validates :shortmessage, presence: true
	validates :reseiver, presence: true
end
