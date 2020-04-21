tool 

extends Spatial

class_name CameraRig

var player: KinematicBody

onready var _position_start: Vector3 = translation

func _ready() -> void:
	set_as_toplevel(true)
	yield(owner, 'ready')
	player = owner

func _get_configuration_warning() -> String:
	return 'Missing player node' if not player else ''