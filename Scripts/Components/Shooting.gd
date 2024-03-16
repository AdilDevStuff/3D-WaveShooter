class_name Shooting
extends Node3D

@export var firerate: float
@export var projectile: PackedScene

@export var spawn_position: Marker3D

var can_shoot: bool = false

func shoot_projectile():
	if can_shoot:
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_transform = spawn_position.global_transform
		owner.get_parent().add_child(projectile_instance)
		can_shoot = false
		await get_tree().create_timer(firerate).timeout
		can_shoot = true
