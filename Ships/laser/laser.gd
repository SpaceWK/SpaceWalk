extends Spatial


var start : Vector3 = Vector3(0, 0, 0) #start of the beam in global coordinates
var end : Vector3 = Vector3(1, 0, 0) #end of the beam in global coordinates
var firing = false

onready var beam = $beam #beam mesh
onready var laser_sound = $Laser

func _ready():
	visible = false

func _process(delta):
	beam.rotation = Vector3(0, 0, 0)
	start = GlobalVars.ship_ref.global_transform.origin
	if firing:
		var midpoint : Vector3 = (start + end) / Vector3(2, 2, 2) #midpoint between the start and end, where the laser will be positioned.
		beam.look_at_from_position(start, midpoint, Vector3.UP)
		beam.rotation_degrees.x += 90
		beam.global_transform.origin = midpoint
		beam.mesh.height = start.distance_to(end)
		

func set_fire(can_fire): #shows / hides laser while mining
	laser_sound.playing = true
	visible = can_fire
	firing = can_fire
	if can_fire == false:
		beam.mesh.height = 1 #reset  the beam to a smaller length
		laser_sound.playing = false
