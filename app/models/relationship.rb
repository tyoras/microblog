class Relationship < ActiveRecord::Base
	#seul l'identifiant d'utilisateur suivi est modifiable
	attr_accessible :followed_id
	#Association indiquant à qui appartient la relation 
	belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  #la validité dépend de la présence de ces 2 champs
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end