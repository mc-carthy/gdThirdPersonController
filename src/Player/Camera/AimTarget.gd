extends Sprite3D

func _ready() -> void:
	set_as_toplevel(true)

func update(ray: RayCast) -> void:
	ray.force_raycast_update()
	var is_colliding: bool = ray.is_colliding()
	visible = is_colliding
	if is_colliding:
		var collision_point: Vector3 = ray.get_collision_point()
		var collision_normal: Vector3 = ray.get_collision_normal()
		global_transform.origin = collision_point + collision_normal * 0.01
		look_at(collision_point - collision_normal, global_transform.basis.y.normalized())
