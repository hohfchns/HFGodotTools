extends Object
class_name OActionStack

var do_stack: Stack = Stack.new()
var undo_stack: Stack = Stack.new()

func do_action(action: AAction) -> void:
	if not action.is_valid:
		printerr("Tried to do action where `is_valid == false`")
		return
	
	do_stack.add(action)
	action.do()
	undo_stack.clear()

func undo() -> void:
	var undo: AAction = do_stack.pop()
	if undo:
		if not undo.is_valid:
			return
		
		undo.undo()
		undo_stack.add(undo)

func redo() -> void:
	var redo: AAction = undo_stack.pop()
	if redo:
		if not redo.is_valid:
			return
		
		redo.redo()
		do_stack.add(redo)
