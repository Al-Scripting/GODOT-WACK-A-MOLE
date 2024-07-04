extends Node2D

signal Assign_P2

var Playing : bool = true
var delay_Spawns : float = 2 
var Hole_picked: bool = false
var delaying : bool = false
var timer : float = 30

var Player1_Score = 0
var Player2_Score = 0

var mole = preload("res://Objects/Mole.tscn")
var rng = RandomNumberGenerator.new()
var Mole_Holes : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("Assign_P2")
	Mole_Holes = get_node("Holes")
	print("Ready function called. Mole_Holes:", Mole_Holes)
	_spawn_mole()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer <= 0:
		Playing = false
	else:
		timer -= delta
		get_node("UI/Time").text = "Time:" + str(round(timer))


func _spawn_mole():
	rng.randomize()
	var hole_index = rng.randi_range(0, Mole_Holes.get_child_count() - 1)
	var hole = Mole_Holes.get_child(hole_index)

	print("Selected hole index:", hole_index)

	if not hole.Occupied:
		print("Hole is not occupied, adding mole")
		var scene_instance = mole.instantiate()
		hole.Occupied = true
		hole.add_child(scene_instance)
		
		var offset_y = -40  # Adjust this value to change how high the mole appears
		# Manually adjust mole's position to the center of the hole
		scene_instance.position = Vector2(0, offset_y)  # Reset the position to the hole's origin
		scene_instance.z_index = 2 # Ensure mole is above the hole
		

		Hole_picked = true
		await_delay()
	else:
		print("Hole is already occupied, skipping")
		await_delay()


func await_delay():
	await get_tree().create_timer(delay_Spawns).timeout
	if delay_Spawns > 0.5:
		delay_Spawns -= 0.1
	delaying = false
	_spawn_mole()




func _on_player_hit_mole():
	Player1_Score += 1
	get_node("UI/Player1_Score").text = "P1: " + str(Player1_Score)
	pass


func _on_player_2_hit_mole():
	Player2_Score += 1
	get_node("UI/Player2_Score").text = "P2: " + str(Player1_Score)
	pass
	pass # Replace with function body.
