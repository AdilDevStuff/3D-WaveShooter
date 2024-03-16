extends CharacterBody3D

@export var follow_speed: float = 20

@export_group("Components")
@export var shooting_component: Shooting
@export var health_component: HealthSystem
@export var navigation_component: NavigationMovement

@onready var player: Player = get_tree().get_first_node_in_group("Player")

var is_in_range: bool = false

func _ready() -> void:
	shooting_component.can_shoot = true

func _process(_delta: float) -> void:
	if is_in_range:
		shooting_component.shoot_projectile()
	
	if health_component.is_health_zero():
		queue_free()

func _physics_process(_delta: float) -> void:
	# Look at target without rotating around
	look_at(player.global_transform.origin)
	navigation_component.update_target_location(player.global_transform.origin)
	navigation_component.follow_target(follow_speed)

func _on_hurt_box_area_entered(area: Area3D) -> void:
	if area.is_in_group("PlayerProjectile"):
		health_component.drop_health(area.projectile_damage)

func _on_shooting_range_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		is_in_range = true

func _on_shooting_range_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		is_in_range = false
