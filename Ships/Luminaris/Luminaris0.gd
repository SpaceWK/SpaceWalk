extends KinematicBody

signal space_state_changed

export var max_speed = 21
export var back_speed = -21
export var acceleration = 0.6
export var pitch_speed = 1.5
export var roll_speed = 1.9
export var yaw_speed = 0.75  # Set lower for linked roll/yaw
export var input_response = 8.0

var in_space : bool setget set_in_space#<-----------------------------------------------------
var velocity = Vector3.ZERO	#					| this variable is used to signal whether or |
var forward_speed = 3#							| not the landing detectors on the ship      |
var pitch_input = 0#							| are activated.                             |
var roll_input = 0#								----------------------------------------------
var yaw_input = 0
var inventory = Inventory.new()

onready var landing_points = $LandingPoints#	  -----------------------------------------------------------------
onready var landing_detectors = $LandingDetectors#| Raycasts that try to detect the planet surface. LandingPoints |
#												  | LandingPoints checks if all three corners of the ship are on  |
#												  | the planet surface. LandingDetectors checks if the ship is in |
#												  | range to land on the planet.                                  |
#												  -----------------------------------------------------------------
func _ready():
	GlobalVars.ship_ref = self

func get_input(delta):
	if Input.is_action_pressed("throttle_up"):
		forward_speed = lerp(forward_speed, max_speed, acceleration * delta)
		$AdvanceDashes.emitting = true
	else:
		$AdvanceDashes.emitting = false
	if Input.is_action_pressed("throttle_down"):
		forward_speed = lerp(forward_speed, back_speed, acceleration * delta)
		$RegressDashes.emitting = true
		$Fire1.visible = false
		$Fire2.visible = false
	else:
		$RegressDashes.emitting = false
		$Fire1.visible = true
		$Fire2.visible = true

	pitch_input = lerp(pitch_input,
			Input.get_action_strength("pitch_up") - Input.get_action_strength("pitch_down"),
			input_response * delta)
	roll_input = lerp(roll_input,
			Input.get_action_strength("roll_left") - Input.get_action_strength("roll_right"),
			input_response * delta)
	yaw_input = lerp(yaw_input,
			Input.get_action_strength("yaw_left") - Input.get_action_strength("yaw_right"),
			input_response * delta)
	# replace the line above with this for linked roll/yaw:
	yaw_input = roll_input


func _physics_process(delta):
	triangulate_normal($LandingPoints/FrontLandingPoint.global_transform.origin, $LandingPoints/LeftLandingPoint.global_transform.origin, $LandingPoints/RightLandingPoint.global_transform.origin)
	get_input(delta)
	transform.basis = transform.basis.rotated(transform.basis.z, roll_input * roll_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.y, yaw_input * yaw_speed * delta)
	transform.basis = transform.basis.orthonormalized()
	velocity = -transform.basis.z * forward_speed
	move_and_collide(velocity * delta)
	
func set_in_space(value): 						#--------------------------------------------------------------------
	in_space = value							#|this is a setget for in_space. When set, this will fire a signal. |
	emit_signal("space_state_changed", value)	#--------------------------------------------------------------------
	
func triangulate_normal(pa : Vector3, pb : Vector3, pc : Vector3):#this function calculates the orientation of the ship relative to the landing points
	var a = pb - pa
	var b = pc - pa
	var normal = a * b
	
