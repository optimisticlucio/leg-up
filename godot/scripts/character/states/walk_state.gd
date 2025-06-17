class_name WalkState
extends CharacterState

static var WALK_SPEED: float = 250;

var facing_right: bool;

func _init(parent_character: Character, facing_right: bool):
	super(parent_character);
	state_name = "Walk State";
	self.facing_right = facing_right;

func enter_state() -> void:
	pass

func get_walk_speed_with_direction() -> float:
	return WALK_SPEED * (1 if facing_right else -1);

func act(characterInput: CharacterInput) -> void:
	parent_character.velocity = Vector2(get_walk_speed_with_direction(), 0);
	parent_character.deterministic_move_and_slide();

func get_next_state(characterInput: CharacterInput) -> CharacterState:
	if (parent_character.deterministic_is_on_floor()):
		return FallState.new(parent_character, 
				Vector2(get_walk_speed_with_direction(), 0));
	if (characterInput.jump):
		return FallState.GetJumpingState(parent_character, 
				Vector2(get_walk_speed_with_direction(), 0));
	if ((characterInput.left && facing_right) || 
		(characterInput.right && !facing_right)):
		# Switch sides!
		return WalkState.new(parent_character, !facing_right);
	if ((!characterInput.right && facing_right) || 
		(!characterInput.left && !facing_right)):
		return IdleState.new(parent_character);
	return self;

func exit_state() -> void:
	pass
