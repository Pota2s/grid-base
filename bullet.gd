extends Node2D

var velocity = 100
var direction

func _process(delta):
	position += velocity * delta * direction.normalized()
