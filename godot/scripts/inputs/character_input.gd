class_name CharacterInput
# Represents player inputs across a single frame.

var left: bool;
var right: bool;
var jump: bool;
var activate: bool;

func _init(left = false, right = false, jump = false, activate = false):
	self.left = left;
	self.right = right;
	self.jump = jump;
	self.activate = activate;

static func get_current_inputs():
	return CharacterInput.new(Input.is_action_pressed("left"), 
		Input.is_action_pressed("right"), 
		Input.is_action_pressed("jump"), 
		Input.is_action_pressed("activate"));
