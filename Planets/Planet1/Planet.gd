tool
extends Spatial

export(Resource) var planet_data setget set_planet_data
export (float) var planet_rotation_speed = 1.0
export(bool) var rotate = true

func set_planet_data(val):
	planet_data = val
	on_data_changed()
	if planet_data != null and not planet_data.is_connected("changed", self, "on_data_changed"):
		planet_data.connect("changed", self, "on_data_changed")

func _ready():
	on_data_changed()
	$EntryField.connect("body_entered", self, "_on_body_entered")
	$PlanetLoadingArea.connect("body_entered", self, "_on_planet_entered")
	
func on_data_changed():
	planet_data.min_height = 99999.0
	planet_data.max_height = 0.0
	#for child in get_children():
		#var face := child as PlanetMeshFace   # might create an infinite loop
		#face.regenerate_mesh(planet_data)

func _on_body_entered(body):
	if body.is_in_group("ship"):
		GlobalVars.ship_last_system_position = body.transform
		GlobalVars.planet_ref = self
		PlanetSurfaceLoader.load_surface(planet_data)

func _on_planet_entered(body):
	if body.is_in_group("ship"):
		PlanetSurfaceLoader.go_to_surface()

func _process(delta):
	if rotate:
		rotate_object_local(Vector3(0, 1, 0), planet_rotation_speed * delta)
