extends Popup

# Video Settings
onready var display = $SettingTabs/Video/MarginContainer/VideoSettings/DisplayBtn
onready var vsync = $SettingTabs/Video/MarginContainer/VideoSettings/VsyncBtn
onready var fps = $SettingTabs/Video/MarginContainer/VideoSettings/FPSBtn
onready var maxFps_value = $SettingTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFPSVal
onready var maxFps = $SettingTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsBtn
onready var bloom = $SettingTabs/Video/MarginContainer/VideoSettings/BloomBtn
onready var brightnes = $SettingTabs/Video/MarginContainer/VideoSettings/BrightnessBtn

# Audio Settings
onready var masterVol = $SettingTabs/Audio/MarginContainer/AudioSettings/MasterVolBtn
onready var musicVol = $SettingTabs/Audio/MarginContainer/AudioSettings/MusicVolBtn
onready var sfxVol = $SettingTabs/Audio/MarginContainer/AudioSettings/SfxValBtn

# Gameplay Settings
onready var fov = $SettingTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovBtn
onready var fov_value = $SettingTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer/FovVal
onready var mouseSens = $SettingTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer2/MouseSensBtn
onready var mouseSens_value = $SettingTabs/Gameplay/MarginContainer/GameplaySettings/HBoxContainer2/SensVal

func _ready():
	display.select(1 if Save.game_data.fullscreen_on else 0)
	GlobalSettings.toggle_fullscreen(Save.game_data.fullscreen_on)
	vsync.pressed = Save.game_data.vsync_on
	fps.pressed = Save.game_data.fps
	maxFps.value = Save.game_data.maxFps
	bloom.pressed = Save.game_data.bloom
	brightnes.value = Save.game_data.brightness
	
	masterVol.value = Save.game_data.masterVol
	
	fov.value = Save.game_data.fov
	mouseSens.value = Save.game_data.mouse_sens
	
	
func _on_DisplayBtn_item_selected(index):
	GlobalSettings.toggle_fullscreen(true if index == 1 else false)


func _on_VsyncBtn_toggled(button_pressed):
	GlobalSettings.toggle_vsync(button_pressed)


func _on_FPSBtn_toggled(button_pressed):
	GlobalSettings.toggle_fps(button_pressed)


func _on_MaxFpsBtn_value_changed(value):
	GlobalSettings.max_fps(value)
	maxFps_value.text = str(value) if value < maxFps.max_value else "max"


func _on_BloomBtn_toggled(button_pressed):
	GlobalSettings.toggle_bloom(button_pressed)


func _on_BrightnessBtn_value_changed(value):
	GlobalSettings.update_brightness(value)


func _on_MasterVolBtn_value_changed(value):
	GlobalSettings.update_masterVol(value)


#func _on_MusicVolBtn_value_changed(value):
	#GlobalSettings.update_masterVol(1, value)


#func _on_SfxValBtn_value_changed(value):
	#pass # Replace with function body.


func _on_FovBtn_value_changed(value):
	GlobalSettings.update_fov(value)
	fov_value.text = str(value)


func _on_MouseSensBtn_value_changed(value):
	GlobalSettings.update_mouse_sens(value)
	mouseSens_value.text = str(value)
