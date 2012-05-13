class Micropost < ActiveRecord::Base
	attr_accessible :content
	#lien d'association avec un user
	belongs_to :user

	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 500 }

	#ordre de récupération par défaut
	default_scope order: 'microposts.created_at DESC'
	#correspond à tous les users suivis par un user donné
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private
	  # Retourne une clause SQL pour avoir les IDs des users suivis par un user donné
	  # incluant son propre ID
	  def self.followed_by(user)
	    followed_user_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
	    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", { user_id: user })
	  end
end