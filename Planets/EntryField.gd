extends Area

class_name EntryField

#This class defines the area around a planet that triggers the player's ship to land

#this is here mostly to avoid headaches when finding a path to the landing point. Child CollisionShape MUST be a SphereShape!!
onready var radius = $CollisionPolygon.shape.radius

func _ready():
	pass # Replace with function body.
