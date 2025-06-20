class_name AssistantExitDoor
extends ExitDoor

func _ready() -> void:
	function_thats_activated = GlobalGameManager.start_actor_phase;
