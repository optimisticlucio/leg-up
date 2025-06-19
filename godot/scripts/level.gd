class_name Level
extends Node2D
# Attached to every scene that is a level.

@export var assistant_level_timer: float = 4; # The amount of seconds you have in your first run.
@export var actor_level_timer: float = 3; # The amoune of seconds you have in your second run.

@export var assistant_spawn_point: Vector2;
@export var assistant_exit_door: ExitDoor;

@export var actor_spawn_point: Vector2;
@export var actor_exit_door: ExitDoor;

@export var level_name: String; # The name of the current level
@export var next_level_path: PackedScene; # The next level that needs to be loaded in.

var level_phase: LevelPhase;
enum LevelPhase {
	ASSISTANT_PHASE,
	ACTOR_PHASE
}

var assistant_recording: CharacterInputHistory;

var assistant: Character;
var actor: Character;

func _ready():
	# Checking I'm not stupid.
	if (actor_level_timer > assistant_level_timer):
		push_error("[ERROR] In level %s, actor has more time than assistant. " % [level_name]);

# Does everything that needs to be done at the end of an assistant phase.
func end_assistant_phase():
	pass

func end_actor_phase():
	pass
