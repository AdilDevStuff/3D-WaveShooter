class_name Projectile
extends Area3D

@export var projectile_speed: float
@export var projectile_damage: float

func _physics_process(delta: float) -> void:
	position -= transform.basis.z * projectile_speed * delta

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
