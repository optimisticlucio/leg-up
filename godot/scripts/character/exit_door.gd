class_name ExitDoor
extends Node2D

@export var character_for_this_door: Character;
var function_thats_activated: Callable;

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("ON BODY ENTERED! %s, looking for %s" % [body, character_for_this_door])
	if (body == character_for_this_door):
		function_thats_activated.call(body);
