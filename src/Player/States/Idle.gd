extends PlayerState

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor():
		if _parent.velocity.length() > 0.01:
			_state_machine.transition_to('Move/Run')
	else:
		_state_machine.transition_to('Move/Air', { velocity = _parent.velocity })

func enter(msg: Dictionary = {}) -> void:
	_parent.velocity = Vector3.ZERO
	skin.transition_to(skin.States.IDLE)
	_parent.enter(msg)

func exit(msg: Dictionary = {}) -> void:
	_parent.exit(msg)
