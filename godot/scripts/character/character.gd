class_name Character
extends CharacterBody2D

@export var character_name: String = "Name Not Set";

var initial_state = IdleState;
var current_state: CharacterState;

var latest_collision: KinematicCollision2D; # from deterministic_move_and_slide

func _init() -> void:
	print(typeof(initial_state));
	current_state = initial_state.new(self);

func _physics_process(_delta: float) -> void:
	state_machine_tick(CharacterInput.get_current_inputs()); # TODO - Check if replay or new.

# Does all the actions of a state machine.
func state_machine_tick(characterInput: CharacterInput):
	var next_state := current_state.get_next_state(characterInput);
	
	if (next_state != current_state):
		print("[{0}] [STATE MACHINE] Switching from {1} to {2}.".format([character_name, current_state.state_name, next_state.state_name]))
		current_state.exit_state();
		next_state.enter_state();
		current_state = next_state;
	
	current_state.act(characterInput);

func deterministic_move_and_slide():
	latest_collision = move_and_collide(velocity * GlobalVariables.TICK_RATE);

func deterministic_is_on_floor() -> bool:
	if latest_collision == null:
		return false
	return latest_collision.get_normal().y < -0.7
