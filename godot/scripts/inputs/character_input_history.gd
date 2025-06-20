class_name CharacterInputHistory
# Holds characterInputs and returns them as requested.

var input_list: Array[CharacterInput];
var input_write_index: int; # Points to the index one after the last written index in the array.
var input_read_index: int; # Points to the first index to read.
# If write==read then there's nothing to read. If read = write - 1 the array is full.

static var ARRAY_BUFFER_MULTIPLIER = 1.2; # Some extra space in case we have extra physics frames.

func _init(how_many_seconds_to_record: float = 5):
	print("[INPUT HISTORY] Size set to %s" % (Engine.physics_ticks_per_second * how_many_seconds_to_record * ARRAY_BUFFER_MULTIPLIER))
	input_list.resize(Engine.physics_ticks_per_second * how_many_seconds_to_record * ARRAY_BUFFER_MULTIPLIER);
	input_write_index = 0;
	input_read_index = 0;

# Writes an input to history, if array is not full.
func write(input: CharacterInput):
	# print("[INPUT HISTORY] writing to index %s, read index is %s" % [input_write_index, input_read_index])
	if (input_read_index == (input_write_index + 1) % len(input_list)):
		push_error("Tried to write to an already full CharacterInputHistory. Input dropped!");
		return;
	
	input_list[input_write_index] = input;
	input_write_index += 1;

# Writes whatever the user is currently pressing to memory.
func write_current_input():
	write(CharacterInput.get_current_inputs());

func read() -> CharacterInput:
	if (input_read_index == input_write_index):
		push_error("Tried to read from an empty CharacterInputHistory. returning null!");
		return null;
	
	var input_to_return = input_list[input_read_index];
	input_read_index += 1;
	
	return input_to_return;
