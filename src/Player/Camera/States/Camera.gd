extends CameraState

export var y_inverted: bool = false
export var deadzone_backwards: float = 0.3
export var sensitivity_gamepad: Vector2 = Vector2(2.5, 2.5)
export var sensitivity_mouse: Vector2 = Vector2(0.1, 0.1)
export var fov_default: float = 70.0

var _input_relative: Vector2 = Vector2.ZERO
var _is_aiming: bool = false

func unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_input_relative += event.get_relative()

func process(delta: float) -> void:
	camera_rig.global_transform.origin = camera_rig.player.global_transform.origin + camera_rig._position_start

	var look_direction: Vector2 = get_look_direction()
	var move_direction: Vector3 = get_move_direction()
	
	if _input_relative.length() > 0.0:
		update_rotation(look_direction * sensitivity_mouse * delta)
		_input_relative = Vector2.ZERO
	if look_direction.length() > 0.0:
		update_rotation(look_direction * sensitivity_gamepad * delta)
	
	var is_in_deadzone: bool = (
		move_direction.x >= -deadzone_backwards and move_direction.x <= deadzone_backwards	
	)
	
	if not is_in_deadzone and not _is_aiming:
		auto_rotate(move_direction)
	
	camera_rig.rotation.y = wrapf(camera_rig.rotation.y, -PI, PI)

func update_rotation(offset: Vector2) -> void:
	camera_rig.rotation.y -= offset.x
	camera_rig.rotation.x += offset.y * -1.0 if y_inverted else offset.y
	camera_rig.rotation.x = clamp(camera_rig.rotation.x, -0.75, 1.25)
	camera_rig.rotation.z = 0

func auto_rotate(move_direction: Vector3) -> void:
	var offset: float = camera_rig.player.rotation.y - camera_rig.rotation.y
	var target_angle: float = (
		camera_rig.player.rotation.y - 2 * PI if offset > PI
		else camera_rig.player.rotation.y + 2 * PI if offset < -PI
		else camera_rig.player.rotation.y
	)
	camera_rig.rotation.y = lerp(camera_rig.rotation.y, target_angle, 0.015)

static func get_look_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength('look_right') -
		Input.get_action_strength('look_left'),
		Input.get_action_strength('look_up') -
		Input.get_action_strength('look_down')
	)

static func get_move_direction() -> Vector3:
	return Vector3(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		0.0,
		Input.get_action_strength('move_backward') - Input.get_action_strength('move_forward')
	)
