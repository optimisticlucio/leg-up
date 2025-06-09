extends Node

var current_scene = null;

func _ready():
	var root = get_tree().root;
	current_scene = root.get_child(-1); # Gets whatever scene was loaded in.

func switch_to_scene(new_scene_path):
	# defer so we don't accidentally stop code that's still running.
	_deferred_goto_scene.call_deferred(new_scene_path)

func _deferred_goto_scene(new_scene_path):
	# It is now safe to remove the current scene.
	current_scene.free()
	var s = ResourceLoader.load(new_scene_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
