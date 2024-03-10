extends Node3D

@export var firerate: float = 0.4
@export var projectile: PackedScene

@export var spawn_position: Marker3D

var can_shoot: bool = true

func _process(delta: float) -> void:
	if Input.is_action_pressed("Shoot"):
		shoot_projectile()

func shoot_projectile():
	if can_shoot:
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_transform = spawn_position.global_transform
		owner.get_parent().add_child(projectile_instance)
		can_shoot = false
		await get_tree().create_timer(firerate).timeout
		can_shoot = true
