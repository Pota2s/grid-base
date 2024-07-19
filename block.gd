extends StaticBody2D

var tile_size = 32
var raycast

var inputs = { "right": Vector2.RIGHT,
"left":Vector2.LEFT,
"up":Vector2.UP,
"down":Vector2.DOWN,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	raycast = $RayCast2D
	position += Vector2.ONE * tile_size / 2

func move(direction):
	raycast.target_position = tile_size * inputs[direction]
	raycast.force_raycast_update()
	
	position += inputs[direction] * tile_size
	
	if raycast.is_colliding():
		var object = raycast.get_collider()
		object.position += inputs[direction] * tile_size

