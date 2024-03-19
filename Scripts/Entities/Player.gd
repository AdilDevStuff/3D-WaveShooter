class_name Player
extends CharacterBody3D

@export_group("Stats")
@export var speed = 5.0
@export var jump_force = 4.5

@export_group("", "")
@export var mouse_sensitivity: float = 0.2

@export_group("Components")
@export var shooting_component: Shooting
@export var health_system: HealthSystem

var is_aiming: bool = false

func _ready() -> void:
	shooting_component.can_shoot = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
 
func _process(_delta: float) -> void:
	shooting_component.aim()
	
	if health_system.is_health_zero():
		get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Shoot"):
		shooting_component.shoot_projectile()
	
	movement(delta)

func movement(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _on_hurt_box_area_entered(area: Area3D) -> void:
	if area is Projectile:
		health_system.drop_health(area.projectile_damage)
