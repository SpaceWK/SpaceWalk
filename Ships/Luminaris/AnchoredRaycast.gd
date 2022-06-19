extends RayCast

#this is a custom script that locks raycast rotation to an axis.
#if this were not here. the raycast would rotate with the parent object

export(bool) var lock_x
export(bool) var lock_y
export(bool) var lock_z

func _physics_process(delta):
	var lock = Vector3(int(lock_x), int(lock_y), int(lock_z)) #lock will either be 1 (true) or 0 (false)
	rotation *= lock #x * 0 = 0; x * 1 = x
