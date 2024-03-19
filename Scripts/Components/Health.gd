class_name HealthSystem
extends Node3D

@export var health: float = 100
@export var health_bar: ProgressBar

#region Health System Methods
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
#endregion

#region Health Bar Styling
func set_health_bar_radius():
	if health_bar.value < health_bar.max_value:
		set_health_bar_corner_radius(6, 0, 6, 0)
	else:
		set_health_bar_corner_radius(6, 6, 6, 6)

func set_health_bar_corner_radius(top_left, top_right, bottom_left, bottom_right):
	var stylebox = health_bar.get_theme_stylebox("fill")
	stylebox.corner_radius_top_left = top_left
	stylebox.corner_radius_top_right = top_right
	stylebox.corner_radius_bottom_left = bottom_left
	stylebox.corner_radius_bottom_right = bottom_right
#endregion
