class_name AssistantExitDoor
extends ExitDoor

func _ready() -> void:
	function_thats_activated = assistant_entered_door;


func assistant_entered_door(assistant: Character):
	if (GlobalGameManager.level_phase == GlobalGameManager.LevelPhase.ASSISTANT_PHASE):
		GlobalGameManager.start_actor_phase();
	else:
		assistant.queue_free();
