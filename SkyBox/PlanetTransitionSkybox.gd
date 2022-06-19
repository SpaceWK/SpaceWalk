extends MeshInstance

#--------------------------------------------------------------------
#| This script is for the "fog" sphere that encircles the ship when |
#| entering another planet. The fog color is determined by each     |
#| planet's PlanetData resource under `fog_color`.                  |
#--------------------------------------------------------------------

var obj : Node #reference to an object. It will probably be a planet, but eventually could include asteroids or space stations.
var distance : float #distance from the planet where fog will start to appear
var radius : float = 0 #radius of the object (subtracted from total distance when calculating fog transparency
var color : Color = Color.whitesmoke #default fog color
var transition_mode : bool #see `transition()` for explanation

func _ready():
	GlobalVars.planet_transition_skybox = self #sets global pointer reference


func transition(mode : bool, col : Color, dist : float, rad : float = 0.0, object : Node = null):
	transition_mode = mode
	color = col#				-----------------------------------------------------------------
	distance = dist#			| Sets variables for the fog transition. If mode is `true`,     |
	radius = rad#				| the transition is for between space and the planet's surface. |
	obj = object#				| `false` is the opposite (surface to space.) `obj` and         |
#								| can be null in surface->space mode.                           |
#								-----------------------------------------------------------------

func _process(delta):
	if distance != 0:
		#the `ramp` calculations convert the distance of the ship between `distance` and the planet surface (distance - radius) into a value between 0 and 1
		if transition_mode:
			if !is_instance_valid(obj) or distance == null:
				return #if `obj` or `distance` is not set, the calculations will abort.
			var ramp = clamp(((distance - radius) - GlobalVars.ship_ref.global_transform.origin.distance_to(obj.global_transform.origin)) / (distance - radius), 0, 1)
			get_surface_material(0).albedo_color = Color(color.r, color.g, color.b, ramp) #sets transparency using the ramp value
		else:
			var ramp = clamp((GlobalVars.ship_ref.global_transform.origin.y - distance) / distance, 0, 1)
			get_surface_material(0).albedo_color = Color(color.r, color.g, color.b, ramp)
			print(GlobalVars.ship_ref.global_transform.origin.y)
			print(ramp)
		
