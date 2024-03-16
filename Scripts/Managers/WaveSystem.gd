class_name WaveSystem
extends Node3D

signal wave_started ## Emitted when the wave is started.
signal wave_completed ## Emitted when the wave is completed.

## Array of enemies to spawn randomly.
@export var enemies: Array[PackedScene]

@export var spawn_rate: float = 0.2 ## Spawn rate of enemies per round.
@export var enemy_count: float = 2 ## Max enemy count per round.
@export var spawn_extents: Vector3 ## Random extents used for spawning enemies.

var wave_count: int = 0

var can_spawn: bool = false
var is_wave_started: bool = false

@onready var spawned_enemies: Node3D = $SpawnedEnemies
@onready var wave_cooldown_timer: Timer = $WaveCooldownTimer
@onready var game_ui: GameUI = get_tree().get_first_node_in_group("GameUI")

func _ready() -> void:
	# Start the wave cool down timer at the game start
	wave_cooldown_timer.start()

func _process(_delta: float) -> void:
	game_ui.set_wave_count(wave_count)
	print_rich("[color=#C22124][b] Enemies Remaining: %d [/b] [/color]" % remaining_enemies())

## Spawn random enemies from an array with a given enemy_count and spawn rate
func spawn_enemy():
	if can_spawn:
		for i in range(enemy_count):
			var enemy_instance = enemies.pick_random().instantiate()
			enemy_instance.position = get_random_spawn_position(-spawn_extents.x, spawn_extents.x, -spawn_extents.y, spawn_extents.y)
			spawned_enemies.add_child(enemy_instance)
			await get_tree().create_timer(spawn_rate).timeout
		can_spawn = false

func get_random_spawn_position(min_x, min_z, max_x, max_z):
	var random_position_x = randf_range(min_x, max_x)
	var random_position_z = randf_range(min_z, max_z)
	var random_position = Vector3(random_position_x, 1.5, random_position_z)
	return random_position

## Get the remaining enemies count left in the scene
func remaining_enemies():
	var enemies_left = 0
	for enemy in spawned_enemies.get_children():
		if enemy is CharacterBody3D:
			enemies_left += 1
	return enemies_left

## Returns true if all enemies are dead otherwise returns false
func are_all_enemies_dead():
	if remaining_enemies() == 0:
		return true
	else:
		return false

func _on_wave_starting_timer_timeout() -> void:
	wave_started.emit()
	wave_cooldown_timer.stop()
	can_spawn = true
	spawn_enemy()

# Check for enemies every 3 seconds
func _on_enemy_alive_check_timer_timeout() -> void:
	if is_wave_started:
		if are_all_enemies_dead():
			wave_completed.emit()

func _on_wave_started() -> void:
	wave_count += 1
	is_wave_started = true
	game_ui.popup_prompt(2.0)
	game_ui.set_prompt_text("Wave Started")
	print_rich("[color=#C22124][b] Wave Started [/b] [/color]")

func _on_wave_completed() -> void:
	is_wave_started = false
	
	# Increase enemy count per wave
	enemy_count += 2
	game_ui.popup_prompt(4.0)
	game_ui.set_prompt_text("Wave Completed! Starting next wave...")
	
	wave_cooldown_timer.start()
	#print_rich("[color=#18D5FF][b] Cool down [/b] [/color]")
