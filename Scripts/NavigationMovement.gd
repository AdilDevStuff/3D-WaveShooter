class_name NavigationMovement
extends Node3D

@export var parent: CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

func update_target_location(target):
	nav_agent.target_position = target

func follow_target(follow_speed: float):
	# Follow target with navigation
	var current_location = global_transform.origin
	await get_tree().process_frame
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = current_location.direction_to(next_location).normalized() * follow_speed
	nav_agent.set_velocity(new_velocity)

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	parent.velocity = parent.velocity.move_toward(safe_velocity, 0.25)
	parent.move_and_slide()
