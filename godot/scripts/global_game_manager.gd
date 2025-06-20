extends Node

var current_scene: Node = null;
var current_level: Level;

var timer_active: bool = false;
var timer_time_left: float = 0; # TODO - Implement timer ticking.
var timer_timeout_event: Callable;

var assistant_replay: CharacterInputHistory; # Holds the assistant's replay.

var level_phase: LevelPhase = LevelPhase.ASSISTANT_PHASE;
enum LevelPhase {
	ASSISTANT_PHASE,
	ACTOR_PHASE
}

func _ready():
	var root = get_tree().root;
	current_scene = root.get_child(-1); # Gets whatever scene was loaded in.


func _process(delta: float) -> void:
	if (timer_active):
		timer_time_left -= delta;
		if (timer_time_left < 0):
			timer_timeout_event.call();

func switch_to_scene(new_scene_path):
	# defer so we don't accidentally stop code that's still running.
	_deferred_goto_scene.call_deferred(new_scene_path)

func _deferred_goto_scene(new_scene):
	current_scene.free()

	var s
	if typeof(new_scene) == TYPE_STRING:
		s = ResourceLoader.load(new_scene)
	elif new_scene is PackedScene:
		s = new_scene
	else:
		push_error("Invalid scene type passed")
		return

	current_scene = s.instantiate()

	if current_scene is Level:
		setup_new_level()

	get_tree().root.add_child(current_scene)

func start_next_level():
	if (current_level.next_level_path):
		switch_to_scene(current_level.next_level_path);
	else:
		switch_to_scene(current_level);

func setup_new_level():
	current_scene = get_tree().current_scene;
	current_level = current_scene;
	level_phase = LevelPhase.ASSISTANT_PHASE;
	
	spawn_assistant(CharacterInputHistory.new(current_level.assistant_level_timer));
	timer_time_left = current_level.assistant_level_timer;
	timer_active = true;
	
	# TODO - Set game over!
	

func start_actor_phase():
	assistant_replay = current_level.assistant.input_replay;

	call_deferred("_deferred_start_actor_phase");


func _deferred_start_actor_phase():
	level_phase = LevelPhase.ACTOR_PHASE;
	get_tree().reload_current_scene();

func setup_actor_phase():
	current_scene = get_tree().current_scene;
	current_level = current_scene;
	spawn_assistant(assistant_replay, true);
	spawn_actor();
	
	timer_time_left = current_level.actor_level_timer;
	timer_active = true;
	# TODO - If assistant touches their door they vanish

func spawn_assistant(recording: CharacterInputHistory, is_replay: bool = false):
	var assistant_scene: PackedScene = preload("res://scenes/characters/assistant.tscn");
	current_level.assistant = assistant_scene.instantiate();
	current_level.assistant.input_replay = recording;
	
	current_level.assistant.position = current_level.assistant_spawn_point.position;
	current_level.assistant.is_playing_replay = is_replay;
	
	current_level.assistant_exit_door.character_for_this_door = current_level.assistant;
	
	get_tree().current_scene.add_child(current_level.assistant);

func spawn_actor():
	var actor_scene: PackedScene = preload("res://scenes/characters/actor.tscn");
	current_level.actor = actor_scene.instantiate();
	
	current_level.actor.position = current_level.actor_spawn_point.position;
	current_level.actor_exit_door.character_for_this_door = current_level.actor;
	
	get_tree().current_scene.add_child(current_level.actor);
	get_tree().get_current_scene()
