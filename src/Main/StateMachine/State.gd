extends Node

class_name State, 'res://assets/2d/icons/state.svg'

onready var _state_machine:= _get_state_machine(self)

var is_active: bool = true setget set_is_active
var _parent: State = null

func _ready() -> void:
	yield(owner, 'ready')
	var parent = get_parent()
	if not parent.is_in_group('state_machine'):
		_parent = parent

func unhandled_input(event: InputEvent) -> void:
	return

func process(delta: float) -> void:
	return

func physics_process(delta: float) -> void:
	return

func enter(msg: Dictionary = {}) -> void:
	return

func exit(msg: Dictionary = {}) -> void:
	return

func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group('state_machine'):
		return _get_state_machine(node.get_parent())
	return node

func set_is_active(value: bool) -> void:
	is_active = value
	set_block_signals(not value)
