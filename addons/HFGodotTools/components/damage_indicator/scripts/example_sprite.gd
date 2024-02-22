extends Sprite2D

@export
var _showcase_label: Label

@export
var _input_action: ManagedInputAction
@export
var _undo_action: ManagedInputAction
@export
var _redo_action: ManagedInputAction

var _press_count: int = 0 : set = set_press_count, get = get_press_count

var _action_stack: OActionStack = OActionStack.new()

func _process(delta):
	if _input_action.just_pressed():
		var action := ACallMethod.new(self, press, unpress)
		_action_stack.do_action(action)
	elif _undo_action.just_pressed():
		_action_stack.undo()
	elif _redo_action.just_pressed():
		_action_stack.redo()

func press() -> void:
	$DamageIndicatorSpawner.spawn()
	_press_count += 1

func unpress() -> void:
	_press_count -= 1

func set_press_count(to: int) -> void:
	_press_count = to
	if is_inside_tree() and _showcase_label:
		_showcase_label.text = "pressed: %s" % _press_count

func get_press_count() -> int:
	return _press_count

