extends Sprite

var res_damage_indicator_ = preload("res://addons/HFGodotTools/Components/DamageIndicator/DamageIndicator.tscn")


func _process(delta):
	# If you want to run the example, add an input action called "test"
	if Input.is_action_just_pressed("test"):
		# Create a damage indicator
		var indicator = res_damage_indicator_.instance()
		# Set it's velocity to a random range, where the first arguemnt is the
		# force (of which the x direction is randomized as well), and the second
		# arugment is maximum variance.
		var velocity = indicator.get_random_velocity(indicator.SENSIBLE_BASE, Vector2(20, 15))
		# Initialize the indicator with the velocity (this line can be combined with the line above)
		indicator.init(velocity)
		# Set the scale of the text to something more visible, since Godot struggles with small fonts
		indicator.set_text_scale(1.5)
		
		# Finally, add it as a child of the desired parent node, a recommendation is using
		# a CanvasLayer as a parent, so the node doesn't move in the world
		add_child(indicator)
