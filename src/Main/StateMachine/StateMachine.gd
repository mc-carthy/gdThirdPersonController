extends Node

class_name StateMachine, 'res://assets/2d/icons/state_machine.svg'

signal transitioned(state_path)

export var initial_state: NodePath = NodePath()

onready var state: State = get_node(initial_state) setget set_state

var is_active: bool = true setget set_is_active
var _state_name: String = ''

func _init() -> void:
	add_to_group('state_machine')

func _ready() -> void:
	yield(owner, 'ready')
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)

func _process(delta: float) -> void:
	state.process(delta)

func _physics_process(delta: float) -> void:
	state.physics_process(delta)

func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_path): return
	var target_state = get_node(target_state_path)
	state.exit()
	self.state = target_state
	state.enter(msg)
	emit_signal('transitioned', target_state_path)

func set_is_active(value: bool) -> void:
	is_active = value
	set_process(value)
	set_physics_process(value)
	set_process_unhandled_input(value)
	state.is_active = value

func set_state(value: State) -> void:
	state = value
	_state_name = value.name
