extends Sprite





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = get_parent().get_parent().speed
	speed = get_parent().get_parent().speed
	position.x -= speed
	if position.x < 0:
		position.x = 1020
