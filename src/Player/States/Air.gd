extends PlayerState

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor():
		if _parent.velocity.length() > 0.01:
			_state_machine.transition_to('Move/Run')
		else:
			_state_machine.transition_to('Move/Idle')

func enter(msg: Dictionary = {}) -> void:
	match msg:
		{ 'velocity': var v, 'jump_impulse': var j }:
			_parent.velocity = v
			_parent.velocity.y = j

	skin.transition_to(skin.States.AIR)
	_parent.enter(msg)

func exit(msg: Dictionary = {}) -> void:
	_parent.exit(msg)
