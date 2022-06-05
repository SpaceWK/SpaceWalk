extends Label

func _ready():
	GlobalSettings.connect("fps_signal", self, "_on_fps_function")


func _process(delta):
	text = "FPS: %s" % [Engine.get_frames_per_second()]


func _on_fps_function(value):
	visible = value
