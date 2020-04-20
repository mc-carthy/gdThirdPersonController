extends Spatial

class_name Mannequiny

enum States { IDLE, RUN, AIR }

onready var animation_tree: AnimationTree = $AnimationTree
onready var _playback: AnimationNodeStateMachinePlayback = animation_tree['parameters/playback']

var move_direction: Vector3 = Vector3.ZERO setget set_move_direction

func _ready() -> void:
	animation_tree.active = true

func transition_to(state_id: int) -> void:
	match state_id:
		States.IDLE:
			_playback.travel('idle')
		States.RUN:
			_playback.travel('move_ground')
		States.AIR:
			_playback.travel('air_jump')
		_:
			_playback.travel('idle')

func set_move_direction(value: Vector3) -> void:
	move_direction = value
	animation_tree['parameters/move_ground/blend_position'] = direction.length()
