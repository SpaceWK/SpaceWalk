extends Spatial

signal mining_interrupted

var ore_yield : int = 25

onready var mining_range = $MiningRange
onready var timer = $Timer

func _ready():
	mining_range.connect("body_entered", self, "_on_body_entered")
	mining_range.connect("body_exited", self, "_on_body_exited")


func mine():
	timer.start()

func _on_body_entered(body):
	if body.is_in_group("ship"):
		destroy()

func destroy():
	GlobalVars.ship_ref.inventory.mineral_tank += ore_yield
	queue_free()
