extends PlayerState

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if _parent.velocity.length() < 0.01:
		_state_machine.transition_to('Move/Idle')

func enter(msg: Dictionary = {}) -> void:
	skin.transition_to(skin.States.RUN)
	_parent.enter(msg)

func exit(msg: Dictionary = {}) -> void:
	_parent.exit(msg)
