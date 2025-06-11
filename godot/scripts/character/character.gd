class_name Character
extends CharacterBody2D

@export var character_name: String = "Name Not Set";

var current_state: CharacterState;

func _physics_process(delta: float) -> void:
	state_machine_tick(CharacterInput.get_current_inputs()); # TODO - Check if replay or new.

# Does all the actions of a state machine.
func state_machine_tick(characterInput: CharacterInput):
	var next_state := current_state.get_next_state(characterInput);
	
	if (next_state != current_state):
		print("[{0}] [STATE MACHINE] Switching from {1} to {2}.".format([character_name, current_state.state_name, next_state.state_name]))
		current_state.exit_state();
		next_state.enter_state();
		current_state = next_state;
	
	current_state.act();
	
