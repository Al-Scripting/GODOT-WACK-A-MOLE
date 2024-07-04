extends CharacterBody2D

signal Hit_Mole

var Contorls_Option = 0 
var Player_velocity = Vector2()
var Speed = 500

var mole_hit = preload("res://Sprites/Mole_hit.png")


func _ready():
	$Area2D/CollisionShape2D.disabled = true
	pass

func Click():
	$Sprite2D.modulate.b = 255
	$Area2D/CollisionShape2D.disabled = false
	await get_tree().create_timer(0.25).timeout
	$Sprite2D.modulate.b = 0
	$Area2D/CollisionShape2D.disabled = true
	pass

func Controls_1():
	if Input.is_key_pressed(KEY_W):
		velocity.y += -Speed
	if Input.is_key_pressed(KEY_S):
		velocity.y += Speed
	if Input.is_key_pressed(KEY_A):
		velocity.x += -Speed
	if Input.is_key_pressed(KEY_D):
		velocity.x += Speed
		
	if Input.is_key_pressed(KEY_SPACE):
		Click()
		

func Controls_2():
	if Input.is_key_pressed(KEY_UP):
		velocity.y += -Speed
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y += Speed
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x += -Speed
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += Speed
	
	if Input.is_key_pressed(KEY_ENTER):
		Click()

func _physics_process(delta):
	velocity = Vector2(0,0)
	if Contorls_Option == 0:
		Controls_1()
	else:
		Controls_2()
	
	move_and_slide()



func _on_scene_assign_p_2():
	Contorls_Option = 2
	pass # Replace with function body.



func _on_area_2d_body_entered(body):
	if body.name == "Mole":
		if body.get_node("Sprite2D").texture != mole_hit:
			body.get_node("Sprite2D").texture = mole_hit
			emit_signal("Hit_Mole")
			body.get_node("Sprite2D").modulate = modulate
			pass
		pass 
