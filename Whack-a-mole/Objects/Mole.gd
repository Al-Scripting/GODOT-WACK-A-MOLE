extends CharacterBody2D

var top_position = 75
var Counted_position = 0
var speed : float = 0.01  # Adjusted speed for visibility
var emerging : bool = true
var orig_position

func _ready():
	orig_position = position
	print("Mole ready. Initial position:", position)
	await_delay()
	pass

func _process(delta):
	if emerging == true:
		position.y -= speed
		Counted_position += speed
	
	if Counted_position > top_position:
		emerging = false
	
	if emerging == false:
		position.y += speed
		Counted_position -= speed
		if Counted_position < 0:
			get_parent().Deactivate()
			queue_free()
			pass

func await_delay():
	await get_tree().create_timer(2.0).timeout
	emerging
