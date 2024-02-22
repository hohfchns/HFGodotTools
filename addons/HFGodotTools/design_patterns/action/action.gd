extends Object
class_name AAction

var is_valid: bool = false

func do() -> void:
	pass

func undo() -> void:
	pass

func redo() -> void:
	do()
