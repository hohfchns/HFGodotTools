extends Control
class_name HFDamageIndicator
# ---------------------- USAGE -------------------------------------------------
# This class is meant to be instantiated from code at the time it's needed.
# 
# The example scene should have all you need to know to use this, it's in the
# same directory as this script.
# ------------------------------------------------------------------------------

@export var gravity := 650.0
@export var friction := 75.0

@export var duration := 0.7
@export var fade_out_duration := 0.1
@export var paused := false
@export var random_velocity := Vector2.ZERO

@onready var _text = $Text
@onready var _duration_timer = $DurationTimer

var initialized := false

var _velocity := Vector2(75, -250)


var _start := false
var _end := false
var _done := false

var _text_scale = 1.0


func init(start_velocity := Vector2(75, -250), gravity := 650.0, friction := 75.0, duration := 0.7, fade_out_duration := 0.1):
	self._velocity = start_velocity
	self.gravity = gravity
	self.friction = friction
	self.duration = duration
	self.fade_out_duration = fade_out_duration


func _ready():
	_text.position = Vector2.ZERO
	_duration_timer.connect("timeout", Callable(self, "_on_duration_timeout"))
	_duration_timer.start(duration)
	randomize_velocity(random_velocity)

func _process(delta):
	if paused:
		_duration_timer.paused = true
		return
	else:
		_duration_timer.paused = false
	
	_text.scale = Vector2(_text_scale, _text_scale)
	
	var side = 1 if _velocity.x > 0 else -1
	
	_velocity.y += gravity * delta
	_velocity.x -= friction * delta * side
	
	if _end:
		var fade_out_tween: Tween = get_tree().create_tween()
		fade_out_tween.tween_property(_text, "modulate:a", 0.0, fade_out_duration)
		
		if not fade_out_tween.is_connected("finished", self.queue_free):
			fade_out_tween.connect("finished", self.queue_free)
	
	_text.global_position += _velocity * delta


func start():
	_duration_timer.start(duration)


func get_random_velocity(base: Vector2, variance: Vector2):
	var new_velocity : Vector2 = base
	
	new_velocity.x += randf_range(-variance.x, variance.x)
	new_velocity.y += randf_range(-variance.y, variance.y)
	
	new_velocity.x *= get_random_dir()
	
	return new_velocity

func get_random_dir():
	var numbers := [1, -1]
	numbers.shuffle()
	
	return numbers[0]

func randomize_velocity(variance: Vector2=Vector2(20, 15)):
	self._velocity = get_random_velocity(_velocity, variance)

func set_text_scale(value : float):
	_text_scale = value


func _on_duration_timeout():
	_end = true

