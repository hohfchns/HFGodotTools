extends Resource
class_name ManagedInputAction

const ACTION_ID_LENGTH = 6

@export
var _inputs: Array[InputEvent]: set = set_inputs, get = get_inputs

var _action_id: String

static var _randomized: bool = false

func _init():
	if not _randomized:
		randomize()
		_randomized = true
	_generate_random_id()

func _generate_random_id():
	_action_id = ""
	for i in range(ACTION_ID_LENGTH):
		_action_id += char(randi_range(0, 255))
	
	if _action_id in InputMap.get_actions():
		_generate_random_id()
		return
	
	InputMap.add_action(_action_id)

func pressed_events() -> Array[InputEvent]:
	var arr: Array[InputEvent] = []
	for input in _inputs:
		var key = input as InputEventKey
		if key and  Input.is_key_pressed(key.keycode):
			arr.append(key)
			continue
		var mouse_button = input as InputEventMouseButton
		if mouse_button and Input.is_mouse_button_pressed(mouse_button.button_index):
			arr.append(mouse_button)
			continue
		var joypad_button = input as InputEventJoypadButton
		if joypad_button and Input.is_joy_button_pressed(joypad_button.device, joypad_button.button_index):
			arr.append(joypad_button)
			continue
	return arr

func just_pressed() -> bool:
	return Input.is_action_just_pressed(_action_id)

func pressed() -> bool:
	return Input.is_action_pressed(_action_id)

func just_released() -> bool:
	return Input.is_action_just_released(_action_id)

func add_input(input: InputEvent) -> void:
	_inputs.append(input)
	InputMap.action_add_event(_action_id, input)

func erase_input(input: InputEvent) -> void:
	_inputs.erase(input)
	InputMap.action_erase_event(_action_id, input)

func set_inputs(inputs: Array[InputEvent]):
	InputMap.action_erase_events(_action_id)
	_inputs = inputs
	for input in inputs:
		InputMap.action_add_event(_action_id, input)

func get_inputs() -> Array[InputEvent]:
	return _inputs


