extends Sprite2D

var _res_damage_indicator = preload("res://addons/HFGodotTools/Components/DamageIndicator/DamageIndicator.tscn")


func _process(delta):
	if Input.is_key_pressed(KEY_1):
		var indicator: HFDamageIndicator = _res_damage_indicator.instantiate()
		indicator.randomize_velocity()
		
		indicator.set_text_scale(1.5)
		
		add_child(indicator)
