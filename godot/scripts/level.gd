class_name Level
extends Node2D
# Attached to every scene that is a level.

@export var assistant_level_timer: float = 40; # The amount of seconds you have in your first run.
@export var actor_level_timer: float = 30; # The amoune of seconds you have in your second run.

@export var assistant_spawn_point: Marker2D;
@export var assistant_exit_door: ExitDoor;

@export var actor_spawn_point: Marker2D;
@export var actor_exit_door: ExitDoor;

@export var level_name: String; # The name of the current level
@export var next_level_path: PackedScene; # The next level that needs to be loaded in.

var assistant: Character;
var actor: Character;

func _ready():
	# Checking I'm not stupid.
	if (actor_level_timer > assistant_level_timer):
		push_error("[ERROR] In level %s, actor has more time than assistant. " % [level_name]);
	
	match (GlobalGameManager.level_phase):
		GlobalGameManager.LevelPhase.ACTOR_PHASE:
			GlobalGameManager.setup_actor_phase();
		GlobalGameManager.LevelPhase.ASSISTANT_PHASE:
			GlobalGameManager.setup_new_level();
		_:
			push_error("[LEVEL] Global manager has unhandled level phase!");

# Does everything that needs to be done at the end of an assistant phase.
func end_assistant_phase():
	pass

func end_actor_phase():
	pass
