extends AAction
class_name ACallMethod

var _target: Object
var _do_func: Callable
var _undo_func: Callable
var _redo_func: Callable

var _do_args: Array
var _undo_args: Array
var _redo_args: Array

func _init( \
	target: Object, \
	do_func: Callable, undo_func: Callable, redo_func: Callable = do_func, \
	do_args: Array = [], undo_args: Array = do_args, redo_args: Array = do_args \
	) -> void:
	
	_target = target
	_do_func = do_func
	_undo_func = undo_func
	_redo_func = redo_func
	_do_args = do_args
	_undo_args = undo_args
	_redo_args = redo_args
	
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
	_do_func.callv(_do_args)

func undo() -> void:
	_undo_func.callv(_undo_args)

func redo() -> void:
	_redo_func.callv(_redo_args)

