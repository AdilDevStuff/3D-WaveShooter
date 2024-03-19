class_name Shooting
extends Node3D

@export_group("Shooting")
@export var firerate: float
@export var projectile: PackedScene
@export var projectile_spawn_position: Marker3D

@export_group("Aiming")
@export var default_camera_position: Vector3
@export var aimed_camera_position: Vector3
@export var camera: Camera3D


var can_shoot: bool = false
var is_aiming: bool = false

func aim():
	if Input.is_action_just_pressed("Aim"):
		is_aiming = !is_aiming
	
	if is_aiming:
		camera.position = lerp(camera.position, aimed_camera_position, 0.2)
		camera.rotation.x = lerpf(camera.rotation.x, 0, 0.2)
	else:
		camera.position = lerp(camera.position, default_camera_position, 0.2)
		camera.rotation.x = lerpf(camera.rotation.x, deg_to_rad(-15), 0.2)

func shoot_projectile():
	if can_shoot:
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_transform = projectile_spawn_position.global_transform
		owner.get_parent().add_child(projectile_instance)
		can_shoot = false
		await get_tree().create_timer(firerate).timeout
		can_shoot = true
