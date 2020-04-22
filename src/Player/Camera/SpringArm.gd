extends SpringArm

export var length_range: Vector2 = Vector2(3.0, 6.0) setget set_length_range
export var zoom: float = 0.5 setget set_zoom

onready var _position_start: Vector3 = translation

func set_length_range(value: Vector2) -> void:
	value.x = max(value.x, 0.0)
	value.y = max(value.y, 0.0)
	length_range.x = min(value.x, value.y)
	length_range.y = max(value.x, value.y)
	self.zoom = zoom

func set_zoom(value: float) -> void:
	zoom = value
	spring_length = length_range.y + length_range.x - lerp(length_range.x, length_range.y, zoom)
