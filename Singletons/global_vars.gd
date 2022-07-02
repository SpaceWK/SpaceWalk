extends Node

signal level_set

const default_env : Environment = preload("res://Godot/SpaceEnvironment.tres")

var level : String = "res://Planets/MiniPlanets/Planets/System.tscn" setget set_level #file path for the current planetary system
var level_ref : Node
var level_instance
var world_env
var system_scale : float = 1.0
var planet_ref : Node
var surface_ref : Node
var ship_ref : Node
var camera_ref : Node
var ship_last_system_position : Transform
var planet_transition_skybox : Node



func set_level(path):
	level = path
	emit_signal("level_set")
