extends CanvasLayer

export(String, FILE) var level

onready var start = $Menu/MarginContainer/VBoxContainer/StartBtn
onready var settings_menu = $Settings_Menu
onready var music = $Background/Music

func _ready():
	start.grab_focus()
	music.playing = true
	

func _on_StartBtn_pressed():
	get_tree().change_scene(level)
	music.playing = false

func _on_SettingsBtn_pressed():
	settings_menu.popup_centered()

func _on_QuitBtn_pressed():
	get_tree().quit()
