class_name GameUI
extends Control

@onready var wave_prompts: Label = $WavePrompts
@onready var ui_animations: AnimationPlayer = $UIAnimations
@onready var wave_count: Label = $WaveCount

func set_prompt_text(text: String):
	wave_prompts.text = text

func set_wave_count(value):
	wave_count.text = "Wave: %d" % value

func popup_prompt(duration: float):
	ui_animations.play("PromptEnter")
	await get_tree().create_timer(duration).timeout
	ui_animations.play_backwards("PromptEnter")
