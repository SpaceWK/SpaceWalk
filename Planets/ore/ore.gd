extends Spatial

signal mining_interrupted

var ore_yield : int = 25

onready var mining_range = $MiningRange
onready var timer = $Timer

func _ready():
	mining_range.connect("body_entered", self, "_on_body_entered")
	mining_range.connect("body_exited", self, "_on_body_exited")
	timer.connect("timeout", self, "_on_timer_timeout")

func mine():
	timer.start()
	
func _on_body_entered(body):
	if body.is_in_group("ship"):
		body.connect("mining_started", self, "_on_mining_started")
		connect("mining_interrupted", body, "_on_mining_interrupted")
		body.can_mine = true

func _on_body_exited(body):
	if body.is_in_group("ship"):
		timer.stop()
		emit_signal("mining_interrupted")
		body.disconnect("mining_started", self, "_on_mining_started")
		disconnect("mining_interrupted", body, "_on_mining_interrupted")
		body.can_mine = false

func destroy():
	GlobalVars.ship_ref.inventory.mineral_tank += ore_yield
	GlobalVars.ship_ref.can_mine = false
	emit_signal("mining_interrupted")
	queue_free()

func _on_mining_started():
	GlobalVars.ship_ref.laser.end = global_transform.origin
	timer.start()
	
func _on_timer_timeout():
	destroy()
