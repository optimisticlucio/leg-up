class_name Level
extends Node2D
# Attached to every scene that is a level.

@export var assistant_level_timer: float; # The amount of seconds you have in your first run.
@export var actor_level_timer: float; # The amoune of seconds you have in your second run.

@export var level_name: String; # The name of the current level
@export var next_level_path: PackedScene; # The next level that needs to be loaded in.
