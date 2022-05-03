extends Spatial

var rotation_speed = 1.0

func _process(delta):
	self.rotate_y(self.rotation_speed * delta)

