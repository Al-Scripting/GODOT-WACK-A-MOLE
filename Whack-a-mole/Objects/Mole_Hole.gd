extends Node2D

var Occupied : bool = false

func _ready():
	pass

func Activate():
	Occupied = true

func Deactivate():
	Occupied = false
