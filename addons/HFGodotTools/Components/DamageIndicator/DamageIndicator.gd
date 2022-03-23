extends Control

# --------------------------------------------------------------------------------------
# This is pretty old code, so no guarentees for updates, beyond this documentation one,
# despite there being obvious improvements to make
# --------------------------------------------------------------------------------------
#
# ---------------------- USAGE -------------------------------------------------
# First of all, do not use this outside of code! It is meant to be instantiated
# at the time it's needed.
# 
# The example scene should have all you need to know to use this, it's in the
# same directory as this.
# ------------------------------------------------------------------------------

const SENSIBLE_BASE := Vector2(75, -250)

export var gravity_ : float
export var friction_ : float

export var duration_ : float
export var fade_out_duration_ : float

onready var __rf_text = $Text
onready var __rf_dur_timer = $DurationTimer
onready var __rf_fade_out_tween = $FadeOutTween

var initialized := false

var velocity_ := Vector2.ZERO

var __start := false
var __end := false
var __done := false

var __text_scale = 1.0


func init(start_velocity := Vector2(75, -250), gravity := 650.0, friction := 75.0, duration := 0.7, fade_out_duration := 0.1):
	self.velocity_ = start_velocity
	self.gravity_ = gravity
	self.friction_ = friction
	self.duration_ = duration
	self.fade_out_duration_ = fade_out_duration
	
	initialized = true


func _ready():
	__rf_text.rect_position = Vector2.ZERO
	__rf_dur_timer.connect("timeout", self, "_on_duration_timeout")
	
	start()


func _process(delta):
	if not initialized:
		printerr("Damage indicator instantiated but not initialized! Use damage_indicator.init()")
		return
	
	if not __start:
		return
	
	__rf_text.rect_scale = Vector2(__text_scale, __text_scale)
	
	var side : int = 1 if velocity_.x > 0 else -1
	
	velocity_.y += gravity_ * delta
	velocity_.x -= friction_ * delta * side
	
	if __end:
		__rf_fade_out_tween.interpolate_property(__rf_text, "modulate:a", __rf_text.modulate.a, 0.0, fade_out_duration_)
		__rf_fade_out_tween.start()
		if not __rf_fade_out_tween.is_connected("tween_completed", self, "_on_fade_out_completed"):
			__rf_fade_out_tween.connect("tween_completed", self, "_on_fade_out_completed")
	
	__rf_text.rect_global_position += velocity_ * delta


func start():
	__rf_dur_timer.start(duration_)
	__start = true


func get_random_velocity(base : Vector2, v2_range : Vector2):
	var new_velocity : Vector2 = base
	
	new_velocity.x += rand_range(-v2_range.x, v2_range.x)
	new_velocity.y += rand_range(-v2_range.y, v2_range.y)
	
	new_velocity.x *= get_random_dir()
	
	return new_velocity

func get_random_dir():
	var numbers := [1, -1]
	numbers.shuffle()
	
	return numbers[0]


func set_text_scale(value : float):
	__text_scale = value


func _on_duration_timeout():
	__end = true


func _on_fade_out_completed(obj, key):
	self.queue_free()
