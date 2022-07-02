extends Spatial

onready var deepspace = $DeepSpace
onready var flying = $Flying

func _ready():
	deepspace.playing = true
	flying.playing = true
	pass
	
	
	
