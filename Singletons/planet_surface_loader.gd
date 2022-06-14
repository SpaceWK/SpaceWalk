extends Node

signal loaded

#This singleton launches a thread to load a planet's surface from a file.
#When finished lading, the thread will close, add the current ship to the new surface scene, notify the rest of the game that it has finished loading, and pass a reference to the surface node

var loader

var system_loaded : bool = false #tracks if the planet system is loaded in.

var _loaded_resource #container variable for the loaded surface file

func _ready():
	GlobalVars.connect("level_set", self, "_on_level_set")
	loader = Thread.new()

func load_surface(var planet_data : PlanetData): #(public) starts the loading thread
	loader.start(self, "_load_surface", planet_data)
	GlobalVars.planet_transition_skybox.transition(
	GlobalVars.planet_ref,
	GlobalVars.ship_ref.global_transform.origin.distance_to(GlobalVars.planet_ref.global_transform.origin),
	planet_data.radius,
	Color(planet_data.fog_color.r, planet_data.fog_color.g, planet_data.fog_color.b, 0.0)
	)

func _load_surface(var planet_data : PlanetData): #(private) loads the surface in a parallel thread and sets the sky fog color for the current planet.
	_loaded_resource = load(planet_data.surface_data_path).instance()
	emit_signal("loaded", _loaded_resource)


func go_to_surface(): #switches to the surface scene
	if is_instance_valid(_loaded_resource):
		GlobalVars.level_ref.queue_free()
		get_tree().get_root().add_child(_loaded_resource)
		GlobalVars.ship_ref.translation = Vector3(64, 120, -64)
		GlobalVars.ship_ref.rotation.x = 180
		GlobalVars.camera_ref.rotation.x += 180
		GlobalVars.surface_ref = _loaded_resource
	
		
func leave_surface():
	if is_instance_valid(GlobalVars.surface_ref):
		GlobalVars.surface_ref.queue_free()
		

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
