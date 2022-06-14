extends MeshInstance



var obj : Node
var distance : float
var radius : float = 0
var color : Color = Color.whitesmoke

func _ready():
	GlobalVars.planet_transition_skybox = self


func transition(object : Node, dist : float, rad : float, col : Color):
	obj = object
	distance = dist
	radius = rad
	color = col
	print(is_instance_valid(obj))
	
func _process(delta):
	if !is_instance_valid(obj) or distance == null:
		return
	else:
#		print(GlobalVars.ship_ref.global_transform.origin)
#		print(obj.global_transform.origin)
		print(GlobalVars.ship_ref.global_transform.origin.distance_to(GlobalVars.planet_ref.global_transform.origin))
		var ramp = clamp(((distance - radius) - GlobalVars.ship_ref.global_transform.origin.distance_to(obj.global_transform.origin)) / (distance - radius), 0, 1)
		#print(ramp)
		get_surface_material(0).albedo_color = Color(color.r, color.g, color.b, ramp)
