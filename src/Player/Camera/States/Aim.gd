extends CameraState

onready var tween: Tween = $Tween

export var fov: float = 40.0
export var offset_camera: Vector3 = Vector3(0.75, -0.7, 0.0)

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('toggle_aim'):
		_state_machine.transition_to('Camera/Default')
	else:
		_parent.unhandled_input(event)

func process(delta: float) -> void:
	_parent.process(delta)

func enter(msg: Dictionary = {}) -> void:
	camera_rig.spring_arm.translation = camera_rig._position_start + offset_camera
	tween.interpolate_property(camera_rig.camera, 'fov', camera_rig.camera.fov, fov, 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func exit(msg: Dictionary = {}) -> void:
	camera_rig.spring_arm.translation = camera_rig._position_start
	tween.interpolate_property(camera_rig.camera, 'fov', camera_rig.camera.fov, _parent.fov_default, 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
