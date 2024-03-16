class_name HealthSystem
extends Node3D

@export var health: float = 100

# Drop health by a given value
func drop_health(value: float):
	health -= value

# Increase health by a given value
func increase_health(value: float):
	health += value

# Check if health is greater than a given value
func is_health_greater_than_value(value: float):
	if health > value: return true
	else: return false

# Check if health is zero
func is_health_zero():
	if health <= 0: return true
	else: return false
