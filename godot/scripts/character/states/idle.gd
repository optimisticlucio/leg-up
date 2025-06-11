class_name IdleState
extends CharacterState

func _init(parent_character: Character):
	super(parent_character);
	state_name = "Idle State";

func enter_state() -> void:
	pass

func act() -> void:
	pass

func get_next_state(characterInput: CharacterInput) -> CharacterState:
	if (characterInput.jump):
		return self; # TODO - pass jump.
	if (characterInput.left || characterInput.right):
		return self; # TODO - pass walking.
	return self;

func exit_state() -> void:
	pass
