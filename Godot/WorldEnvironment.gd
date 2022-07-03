extends WorldEnvironment

func _ready():
	GlobalVars.world_env = self
	GlobalSettings.connect("bloom_signal", self, "bloom_toggled")
	GlobalSettings.connect("brightness_signal", self, "brightness_updated")

func bloom_toggled(value):
	environment.glow_enabled = value
	
func brightness_updated(value):
	environment.adjustment_brightness = value
