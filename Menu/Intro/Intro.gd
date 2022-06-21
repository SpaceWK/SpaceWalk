extends Node

func _ready():
	$AnimationPlayer.play("Fade In")
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer.play("Fade Out")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://Menu/Start_Menu/Start_Menu.tscn")
