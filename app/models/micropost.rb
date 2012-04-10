class Micropost < ActiveRecord::Base
	attr_accessible :content
	#lien d'association avec un user
	belongs_to :user

	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 500 }

	#ordre de récupération par défaut
	default_scope order: 'microposts.created_at DESC'
end