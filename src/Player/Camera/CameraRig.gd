tool 

extends Spatial

class_name CameraRig

var player: KinematicBody
var zoom: float = 0.5 setget set_zoom

onready var _position_start: Vector3 = translation
onready var spring_arm: SpringArm = $SpringArm
onready var camera: InterpolatedCamera = $InterpolatedCamera
onready var aim_ray: RayCast = $InterpolatedCamera/AimRay
onready var aim_target: Sprite3D = $AimTarget

func _ready() -> void:
	set_as_toplevel(true)
	yield(owner, 'ready')
	player = owner

func _get_configuration_warning() -> String:
	return 'Missing player node' if not player else ''

func set_zoom(value: float) -> void:
	zoom = clamp(value, 0, 1)
	spring_arm.zoom = zoom
