class_name GameManager
extends Node3D

var is_mouse_visible: bool = false

func _process(_delta: float) -> void:
	show_hide_mouse_cursor()

## ---------- Debug Functions ---------- ##

## Show and hide mouse cursor if pressing escape key
func show_hide_mouse_cursor():
	if is_mouse_visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_just_pressed("ShowMouseCursor"):
		is_mouse_visible = !is_mouse_visible
