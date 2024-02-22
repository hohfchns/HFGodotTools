extends AAction
class_name ASetVariable

var target: Node
var variable_name: StringName
var set_value: Variant = null

var _last_value: Variant = null : set = set_last_value, get = get_last_value

func _init(target: Node, variable_name: StringName, set_value: Variant) -> void:
	self.target = target
	self.variable_name = variable_name
	self.set_value = set_value
	
	if target.is_inside_tree():
		is_valid = true
	else:
		target.tree_entered.connect(
			func():
				is_valid = true
		)
	
	target.tree_exited.connect(
		func():
			is_valid = false
	)

func do() -> void:
	_last_value = target.get(variable_name)
	target.set(variable_name, set_value)

func undo() -> void:
	if not _last_value:
		return
	
	set_value = target.get(variable_name)
	target.set(variable_name, _last_value)

func set_last_value(to: Variant) -> void:
	_last_value = to

func get_last_value() -> Variant:
	return _last_value
