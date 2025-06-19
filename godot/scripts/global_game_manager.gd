extends Node

var current_scene: Node = null;
var current_level: Level;

var timer_active: bool = false;
var timer_time_left: float = 0; # TODO - Implement timer ticking.
var timer_timeout_event: Callable;

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

func _deferred_goto_scene(new_scene_path):
	# It is now safe to remove the current scene.
	current_scene.free()
	var s = ResourceLoader.load(new_scene_path)
	current_scene = s.instantiate()
	
	if (current_scene is Level):
		setup_new_level(current_scene)
		
	get_tree().root.add_child(current_scene)

func setup_new_level(scene: Level):
	current_level = scene;
	scene.level_phase = Level.LevelPhase.ASSISTANT_PHASE;
	
	spawn_assistant(CharacterInputHistory.new(current_level.assistant_level_timer));
	timer_time_left = current_level.assistant_level_timer;
	timer_active = true;
	# TODO - Set game over!
	

func setup_actor_phase():
	var actor_replay = current_level.assistant_recording;
	
	get_tree().reload_current_scene();
	
	current_level = current_scene;
	spawn_assistant(actor_replay, true);
	spawn_actor();
	
	timer_time_left = current_level.actor_level_timer;
	timer_active = true;
	# TODO - Set game over!

func spawn_assistant(recording: CharacterInputHistory, is_replay: bool = false):
	var assistant_scene: PackedScene = preload("res://scenes/characters/assistant.tscn");
	current_level.assistant = assistant_scene.instantiate();
	current_level.assistant.input_replay = recording;
	
	current_level.assistant.position = current_level.assistant_spawn_point;
	current_level.assistant.is_playing_replay = is_replay;

func spawn_actor():
	var actor_scene: PackedScene = preload("res://scenes/characters/actor.tscn");
	current_level.actor = actor_scene.instantiate();
	
	current_level.actor.position = current_level.actor_spawn_point;
	
