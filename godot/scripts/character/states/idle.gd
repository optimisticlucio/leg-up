class_name IdleState
extends CharacterState

func _init(parent_character: Character):
	super(parent_character);
	state_name = "Idle State";

func enter_state() -> void:
	parent_character.velocity = Vector2.ZERO;

func act(characterInput: CharacterInput) -> void:
	pass

func get_next_state(characterInput: CharacterInput) -> CharacterState:
	if (!parent_character.deterministic_is_on_floor()):
		return FallState.new(parent_character);
	if (characterInput.jump):
		return FallState.GetJumpingState(parent_character);
	if (characterInput.left || characterInput.right):
		return WalkState.new(parent_character, characterInput.right);
	return self;

func exit_state() -> void:
	pass
