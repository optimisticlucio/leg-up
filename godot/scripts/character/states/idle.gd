class_name IdleState
extends CharacterState

func _init(parent_character: Character):
	super(parent_character);
	state_name = "Idle State";

func enter_state() -> void:
	parent_character.velocity = Vector2.ZERO;

func act() -> void:
	pass

func get_next_state(characterInput: CharacterInput) -> CharacterState:
	if (!parent_character.deterministic_is_on_floor()):
		return FallState.new(parent_character);
	if (characterInput.jump):
		return self; # TODO - pass jump.
	if (characterInput.left || characterInput.right):
		return self; # TODO - pass walking.
	return self;

func exit_state() -> void:
	pass
