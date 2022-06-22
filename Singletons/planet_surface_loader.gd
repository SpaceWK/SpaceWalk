extends Node

signal loaded

#This singleton launches a thread to load a planet's surface from a file.
#When finished lading, the thread will close, add the current ship to the new surface scene, notify the rest of the game that it has finished loading, and pass a reference to the surface node
#TODO: if time allows, use ResourceInteractiveLoader instead of `load()`

var system_loaded : bool = false #tracks if the planet system is loaded in.

var _loaded_resource #container variable for the loaded surface file

func _ready():
	GlobalVars.connect("level_set", self, "_on_level_set")

func load_surface(var planet_data : PlanetData): #(public) starts the loading thread
	_load_surface(planet_data)
	GlobalVars.planet_transition_skybox.transition( #see SkyBox/PlanetTransitionSkybox.gd
	true,
	Color(planet_data.fog_color.r, planet_data.fog_color.g, planet_data.fog_color.b, 0.0),
	GlobalVars.ship_ref.global_transform.origin.distance_to(GlobalVars.planet_ref.global_transform.origin),
	planet_data.radius,
	GlobalVars.planet_ref
	)

func _load_surface(var planet_data : PlanetData): #(private) loads the surface in a parallel thread and sets the sky fog color for the current planet.
	_loaded_resource = load(planet_data.surface_data_path).instance()
	emit_signal("loaded", _loaded_resource)


func go_to_surface(data : PlanetData): #switches to the surface scene
	if is_instance_valid(_loaded_resource):
		GlobalVars.level_ref.queue_free()
		GlobalVars.ship_ref.translation = Vector3(45, 120, 45)
		get_tree().get_root().add_child(_loaded_resource)
		GlobalVars.surface_ref = _loaded_resource
		GlobalVars.planet_transition_skybox.transition( #see SkyBox/PlanetTransitionSkybox.gd
		false,
		Color(data.fog_color.r, data.fog_color.g, data.fog_color.b, 0.0),
		GlobalVars.ship_ref.global_transform.origin.distance_to(GlobalVars.planet_ref.global_transform.origin)
		)
	
		
func leave_surface():
	if is_instance_valid(GlobalVars.surface_ref):
		GlobalVars.surface_ref.queue_free()
		get_tree().get_root().add_child(GlobalVars.level_instance)
		GlobalVars.ship_ref.transform = GlobalVars.ship_last_system_position
#		GlobalVars.ship_ref.rotate
		

func unload():
	if _loaded_resource != null:
		_loaded_resource.free()
		_loaded_resource = null

func _on_level_set():
	system_loaded = bool(GlobalVars.level)

func save_position(var planet_name : String):
	pass

func load_system():
	pass
