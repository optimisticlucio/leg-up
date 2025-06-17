class_name CharacterState

var state_name: String = "State Name Not Set";
var parent_character: Character;

func _init(parent_character: Character):
	self.parent_character = parent_character;

func enter_state() -> void:
	pass

func act(characterInput: CharacterInput) -> void:
	push_error("UNIMPLEMENTED ACT IN " + state_name);

func get_next_state(characterInput: CharacterInput) -> CharacterState:
	push_error("UNIMPLEMENTED GET_NEXT_STATE IN " + state_name);
	return self;

func exit_state() -> void:
	pass
