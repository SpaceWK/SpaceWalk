extends Control

onready var mineral_counter = $Minerals

onready var missions

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mineral_counter.text = "Minerals: %s/%s" % [str(GlobalVars.ship_ref.inventory.mineral_tank), str(GlobalVars.ship_ref.inventory.max_minerals)]
