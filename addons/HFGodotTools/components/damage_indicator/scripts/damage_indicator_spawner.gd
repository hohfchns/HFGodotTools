@tool
extends Node

@export_node_path("Node2D", "Node3D", "Control", "CanvasItem", "CanvasLayer")
var __parent: NodePath
@onready
var parent = get_node(__parent)
@export
var text_scale := 1.5
@export
var randomize := true

@export
var _editor_spawn: bool = false

var _res_damage_indicator: PackedScene = preload("res://addons/HFGodotTools/components/damage_indicator/prefabs/damage_indicator.tscn")

func spawn() -> void:
	var indicator: HFDamageIndicator = _res_damage_indicator.instantiate()
	if randomize:
		indicator.randomize_velocity()
	
	indicator.set_text_scale(text_scale)
	
	if parent == null:
		get_parent().add_child(indicator)
	else:
		parent.add_child(indicator)

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if _editor_spawn:
			spawn()
			_editor_spawn = false
