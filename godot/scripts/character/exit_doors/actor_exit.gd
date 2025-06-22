class_name ActorExitDoor
extends ExitDoor

func _ready() -> void:
	function_thats_activated = actor_entered_door;

func actor_entered_door(actor: Character):
	GlobalGameManager.start_next_level();
