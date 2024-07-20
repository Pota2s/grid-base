extends Area2D

var tile_size = 32
var inputs = { "right": Vector2.RIGHT,
"left":Vector2.LEFT,
"up":Vector2.UP,
"down":Vector2.DOWN,
}

var Bullet = load("res://bullet.tscn")
var raycast
var arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	raycast = $RayCast2D
	arrow = $RedArrow
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

func move(direction):
	raycast.target_position = tile_size * inputs[direction]
	raycast.force_raycast_update()
	
	if !raycast.is_colliding():
		position += inputs[direction] * tile_size
	
	if raycast.is_colliding():
		var object = raycast.get_collider()
		object.move(direction)

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func _process(delta):
	var mouse_pos = get_local_mouse_position().normalized()
	arrow.position = tile_size/2 * mouse_pos
	arrow.rotation = mouse_pos.angle()
	


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var bullet = Bullet.instantiate()
			add_sibling(bullet)
			bullet.position = position 
			bullet.direction = event.position - bullet.position
