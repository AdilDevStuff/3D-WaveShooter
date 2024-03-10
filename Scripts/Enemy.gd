extends CharacterBody3D

@export var follow_speed: float = 20

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

@onready var health_system: HealthSystem = $HealthSystem

func _process(delta: float) -> void:
	if health_system.is_health_zero():
		queue_free()

func _physics_process(delta: float) -> void:
	update_target_location(player.global_transform.origin)
	
	follow_player(delta)

func update_target_location(target):
	nav_agent.target_position = target

func follow_player(delta):
	# Follow player with navigation
	var current_location = global_transform.origin
	await get_tree().process_frame
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = current_location.direction_to(next_location).normalized() * follow_speed
	nav_agent.set_velocity(new_velocity)

	# Look at player without rotating around
	look_at(player.global_transform.origin)

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, 0.25)
	move_and_slide()

func _on_hurt_box_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player"):
		health_system.drop_health(area.projectile_damage)
