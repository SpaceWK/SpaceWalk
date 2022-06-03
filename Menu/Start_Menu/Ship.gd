extends KinematicBody

var velocity = Vector3.ZERO
var forward_speed = 0.2


func _physics_process(delta):
	velocity = transform.basis.z * forward_speed
	move_and_collide(velocity * delta)
