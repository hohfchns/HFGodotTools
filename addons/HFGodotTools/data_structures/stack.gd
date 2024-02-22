extends Object
class_name OStack

var _arr: Array[Variant] = []

func pop() -> Variant:
	if not _arr.size():
		return null
	
	return _arr.pop_back()

func add(obj: Variant) -> void:
	_arr.push_back(obj)

func top() -> Variant:
	if not _arr.size():
		return null
	
	return _arr.back()

func size() -> int:
	return _arr.size()

func map(call: Callable) -> OStack:
	var new: OStack
	for element in _arr:
		new.add(call(element))
	
	return new

func call_on_elements(method: StringName) -> void:
	for element in _arr:
		element.call(method)

func clear() -> void:
	_arr.clear()
