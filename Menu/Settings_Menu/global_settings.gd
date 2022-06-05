extends Node

signal fps_signal(value)
signal bloom_signal(value)
signal brightness_signal(value)
signal fov_signal(value)
signal mouse_sens_signal(value)

func toggle_fullscreen(value):
	OS.window_fullscreen = value
	Save.game_data.fullscreen_on = value
	Save.save_data()

func toggle_vsync(value):
	OS.vsync_enabled = value
	Save.game_data.vsync_on = value
	Save.save_data()

func toggle_fps(value):
	emit_signal("fps_signal", value)
	Save.game_data.fps = value
	Save.save_data()

func max_fps(value):
	Engine.target_fps = value if value < 200 else 0
	Save.game_data.maxFps = Engine.target_fps if value < 200 else 0
	Save.save_data()

func toggle_bloom(value):
	emit_signal("bloom_signal", value)
	Save.game_data.bloom = value
	Save.save_data()

func update_brightness(value):
	emit_signal("brightness_signal", value)
	Save.game_data.brightness = value
	Save.save_data()
	
func update_masterVol(vol):
	AudioServer.set_bus_volume_db(0, vol)
	Save.game_data.masterVol = vol
	Save.save_data()

func update_fov(value):
	emit_signal("fov_signal", value)
	Save.game_data.fov = value
	Save.save_data()
	
func update_mouse_sens(value):
	emit_signal("mouse_sens_signal", value)
	Save.game_data.mouse_sens = value
	Save.save_data()
