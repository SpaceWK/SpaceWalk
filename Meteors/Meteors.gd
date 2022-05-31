extends KinematicBody


export var speed = 0.1

var velocity = Vector3.ZERO
var rotation_speed = 0.1

func _process(delta):
	var direction = Vector3.ZERO

	direction.x += 1
	
	velocity.x = direction.x * speed
	# Moving the character
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	self.rotate_y(self.rotation_speed * delta)
