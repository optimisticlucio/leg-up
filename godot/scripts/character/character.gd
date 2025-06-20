class_name Character
extends CharacterBody2D

@export var character_name: String = "Name Not Set";

var initial_state = IdleState;
var current_state: CharacterState;

var input_replay: CharacterInputHistory;
var is_playing_replay: bool; # If true, reads from input_replay. If else, writes to.

var latest_collision: KinematicCollision2D; # from deterministic_move_and_slide

func _init(input_replay: CharacterInputHistory = null, is_playing_replay: bool = false) -> void:
	print(typeof(initial_state));
	current_state = initial_state.new(self);
	
	if (input_replay == null):
		self.input_replay = CharacterInputHistory.new();
	else:
		self.input_replay = input_replay;
	
	self.is_playing_replay = is_playing_replay;

func _physics_process(_delta: float) -> void:
	var next_inputs: CharacterInput = CharacterInput.new();

	if (!is_playing_replay):
		next_inputs = CharacterInput.get_current_inputs();
		input_replay.write(next_inputs);
	else:
		if (input_replay):
			next_inputs = input_replay.read();
	
	state_machine_tick(next_inputs);

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
