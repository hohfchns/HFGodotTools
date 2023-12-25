extends Sprite2D

var _res_damage_indicator = preload("res://addons/HFGodotTools/components/damage_indicator/prefabs/damage_indicator.tscn")
@export
var _input_action: ManagedInputAction

func _process(delta):
	if _input_action.just_pressed():
		$DamageIndicatorSpawner.spawn()
