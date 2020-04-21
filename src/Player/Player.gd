tool

extends KinematicBody

class_name Player

onready var camera: CameraRig = $CameraRig
onready var skin: Mannequiny = $Mannequiny
onready var state_machine: StateMachine = $StateMachine

func _get_configuration_warning() -> String:
	return 'Missing Camera node' if not camera else ''
