extends Control

onready var mineral_counter = $Minerals
onready var mineral_notif = $MineralNotif

onready var missions

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mineral_counter.text = "Minerals: %s/%s" % [str(GlobalVars.ship_ref.inventory.mineral_tank), str(GlobalVars.ship_ref.inventory.max_minerals)]
	mineral_notif.visible = GlobalVars.ship_ref.can_mine
	if GlobalVars.ship_ref.inventory.mineral_tank == GlobalVars.ship_ref.inventory.max_minerals:
		mineral_counter.modulate = Color(0.125, 1, 0, 1)
