extends Spatial

var enabled = false

export var x_offset = 0
export var y_offset = 0
export var z_offset = 0

export var inverse_x = false
export var inverse_y = false

export var sensitivity_x = 300
export var sensitivity_y = 300

export var mouse_sens = 0.1

export (NodePath) var target
onready var sprite = get_node(target)
onready var camera = $Camera

# // Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVars.camera_ref = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	enabled = true
	inverse()
	GlobalSettings.connect("fov_signal", self, "fov_updated")
	GlobalSettings.connect("mouse_sens_signal", self, "mouse_sens_updated")

# // Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	transform.origin.y = sprite.transform.origin.y + y_offset
	transform.origin.z = sprite.transform.origin.z + z_offset
	transform.origin.x = sprite.transform.origin.x + x_offset

func inverse():
	if inverse_x:
		sensitivity_x *= -1
	if inverse_y:
		sensitivity_y *= -1

# // Call this methods once for toggle axis inversion.
func _inverse_x():
	sensitivity_x *= -1

func _inverse_y():
	sensitivity_y *= -1

func _input(event):
	if Input.is_action_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		enabled = false
		
	# resetare mouse pe captured si sa pot folosi in continouare mouse ul
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		enabled = true
		inverse()
	
	if event is InputEventMouseMotion && enabled:
		rotation.y += event.relative.x / -sensitivity_x
		rotation.x += event.relative.y / -sensitivity_y

func fov_updated(value):
	camera.fov = value
	
func mouse_sens_updated(value):
	mouse_sens = value
