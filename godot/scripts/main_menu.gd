extends Node2D


func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("jump")):
		GlobalGameManager.switch_to_scene("res://scenes/test_scene.tscn");
