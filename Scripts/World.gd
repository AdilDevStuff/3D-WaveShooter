extends Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $Player.position.y <= -3:
		get_tree().reload_current_scene()
