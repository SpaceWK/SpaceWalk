extends Node

#This singleton launches a thread to load a planet's surface from a file.
#When finished lading, the thread will close, add the current ship to the new surface scene, notify the rest of the game that it has finished loading, and pass a reference to the surface node

var loader

func _ready():
	var loader = Thread.new()

func load_surface(var planet_id : int):
	loader.st

func _load_surface(var surface_data):
	pass
