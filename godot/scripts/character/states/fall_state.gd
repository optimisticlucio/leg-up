class_name FallState
extends CharacterState

var gravity: float = GlobalVariables.DEFAULT_GRAVITY;
static var MAX_FALL_SPEED: float = 700;

func _init(parent_character: Character, momentum: Vector2 = Vector2.ZERO):
	super(parent_character);
	state_name = "Fall State";
	parent_character.velocity = momentum;

func enter_state() -> void:
	pass

func act() -> void:
	# TODO: Update velocity according to gravity.
	if (parent_character.velocity.y < MAX_FALL_SPEED):
		parent_character.velocity.y += gravity * GlobalVariables.TICK_RATE;
	parent_character.deterministic_move_and_slide();

func get_next_state(characterInput: CharacterInput) -> CharacterState:
	if (parent_character.deterministic_is_on_floor()):
		return IdleState.new(parent_character);
	return self;

func exit_state() -> void:
	pass
