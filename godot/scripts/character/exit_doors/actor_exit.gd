class_name ActorExitDoor
extends ExitDoor

func _ready() -> void:
	function_thats_activated = GlobalGameManager.start_next_level;
