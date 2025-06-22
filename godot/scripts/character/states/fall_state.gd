class_name FallState
extends CharacterState

var gravity: float = GlobalVariables.DEFAULT_GRAVITY;

static var MAX_FALL_SPEED: float = 700;
static var JUMP_STRENGTH: float = 600;
static var HORIZONTAL_ACCELERATION: float = 600;
static var MAX_HORIZONTAL_SPEED: float = 400;

func _init(parent_character: Character, momentum: Vector2 = Vector2.ZERO):
	super(parent_character);
	state_name = "Fall State";
	parent_character.velocity = momentum;

static func GetJumpingState(parent_character: Character, momentum: Vector2 = Vector2.ZERO):
	var newState = FallState.new(parent_character, momentum + Vector2(0, -JUMP_STRENGTH));
	return newState;

func enter_state() -> void:
	pass

func act(characterInput: CharacterInput) -> void:
	if (parent_character.velocity.y < 0 && !characterInput.jump): 
		parent_character.velocity.y = 0;
	
	if (parent_character.velocity.y < MAX_FALL_SPEED):
		parent_character.velocity.y += gravity * GlobalVariables.TICK_RATE;
	
	# Footstool handling
	if (parent_character.velocity.y >= 0 && characterInput.jump && another_character_is_below()):
		parent_character.velocity.y =  -JUMP_STRENGTH;
	
	if (characterInput.right && parent_character.velocity.x < MAX_HORIZONTAL_SPEED):
		parent_character.velocity.x += HORIZONTAL_ACCELERATION * GlobalVariables.TICK_RATE;
	elif (characterInput.left && parent_character.velocity.x > -MAX_HORIZONTAL_SPEED):
		parent_character.velocity.x -= HORIZONTAL_ACCELERATION * GlobalVariables.TICK_RATE;

	parent_character.deterministic_move_and_slide();

func get_next_state(characterInput: CharacterInput) -> CharacterState:
	if (parent_character.deterministic_is_on_floor()):
		return IdleState.new(parent_character);
	return self;

func exit_state() -> void:
	pass

func another_character_is_below() -> bool:
	if parent_character.bottom_raycasts == null:
		return false;
	
	return parent_character.bottom_raycasts.all(func(raycast: RayCast2D): return raycast.is_colliding());
