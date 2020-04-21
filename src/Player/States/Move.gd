extends PlayerState

export var maximum_speed: float = 300.0
export var move_speed: float = 300.0
export var gravity: float = -80.0
export var jump_impulse: float = 25.0

var velocity: Vector3 = Vector3.ZERO

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('jump'):
		_state_machine.transition_to('Move/Air', { velocity = velocity, jump_impulse = jump_impulse })

func physics_process(delta: float) -> void:
	var input_direction: Vector3 = get_input_direction()
	var forward: Vector3 = player.camera.global_transform.basis.z * input_direction.z
	var right: Vector3 = player.camera.global_transform.basis.x * input_direction.x
	var move_direction: Vector3 = forward + right
	if move_direction.length() > 1.0:
		move_direction = move_direction.normalized()
	move_direction.y = 0
	skin.move_direction = move_direction
	
	if move_direction:
		player.look_at(player.global_transform.origin + move_direction, Vector3.UP)
	
	velocity = calculate_velocity(velocity, move_direction, delta)
	velocity = player.move_and_slide(velocity, Vector3.UP)

static func get_input_direction() -> Vector3:
	return Vector3(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		0.0,
		Input.get_action_strength('move_backward') - Input.get_action_strength('move_forward')
	)

func calculate_velocity(current_velocity: Vector3, move_direction: Vector3, delta: float) -> Vector3:
	var new_velocity: Vector3 = current_velocity
	
	new_velocity = move_direction * move_speed * delta
	if new_velocity.length() > maximum_speed:
		new_velocity = new_velocity.normalized() * maximum_speed
	new_velocity.y = current_velocity.y + gravity * delta
	
	return new_velocity
