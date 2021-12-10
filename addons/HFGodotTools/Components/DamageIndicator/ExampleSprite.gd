extends Sprite

var res_damage_indicator_ = preload("res://addons/HFGodotTools/Components/DamageIndicator/DamageIndicator.tscn")


func _process(delta):
	if Input.is_action_just_pressed("test"):
		var indicator = res_damage_indicator_.instance()
		var velocity = indicator.get_random_velocity(indicator.SENSIBLE_BASE, Vector2(20, 15))
		indicator.init(velocity)
		indicator.set_text_scale(1.5)
		
		add_child(indicator)
