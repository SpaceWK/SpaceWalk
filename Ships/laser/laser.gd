extends Spatial


var start : Vector3 = Vector3(0, 0, 0) #start of the beam in global coordinates
var end : Vector3 = Vector3(1, 0, 0) #end of the beam in global coordinates

onready var beam = $beam #beam mesh



func _ready():
	pass

func _process(delta):
	end = $Position3D.global_transform.origin
	var midpoint : Vector3 = (start + end) / Vector3(2, 2, 2) #midpoint between the start and end, where the laser will be positioned.
	beam.global_transform.origin = midpoint
	beam.transform.basis = Basis()
	beam *= (start-end).normalized()
	
	
	
	
