@tool
extends Node
class_name ThemeManager

## The object type as defined in the theme
@export
var _theme_type: StringName: set = set_theme_type, get = get_theme_type

## The nodes to apply the theming to
@export
var _theming_map: Array[ThemeMapData]

func _ready() -> void:
	refresh_theming()

func refresh_theming() -> void:
	for m in _theming_map:
		var node := get_node(m.node_path) as Control
		var set_override_func := node.get("add_theme_%s_override" % m.property_type) as Callable
		var retrieve_func := node.get("get_theme_%s" % m.property_type) as Callable
		var retrieved_property = retrieve_func.call(m.theme_property, _theme_type)
		set_override_func.call(m.node_override, retrieved_property)
		if node is TextureRect and m.property_type == "icon":
			node.texture = retrieved_property

func change_property(for_node: Node, override: StringName, new_value: StringName) -> void:
	var found := false
	
	for m in _theming_map:
		if get_node(m.node_path) == for_node:
			if m.node_override == override:
				m.theme_property = new_value
				found = true
	
	if not found:
		printerr("Error! Could not find node %s with override %s in theming map" % [for_node, override])
		return
	
	refresh_theming()

func set_theme_type(value: StringName) -> void:
	_theme_type = value
	if is_inside_tree():
		refresh_theming.call_deferred()

func get_theme_type() -> StringName:
	return _theme_type
