extends KinematicBody2D

var velocity = Vector2()
var gravity = 2000
var restart = false
var max_jump_high = 800
var jumping = false
var running = true
var shift = false
var dead = false


func _ready():
	jumping = false
	running = true
	shift = false
	dead = false
	
func _physics_process(delta):	
	animation()
	get_input(delta)	
	velocity = move_and_slide(velocity, Vector2.UP)

func game_over():
	dead = true
	get_parent().speed = 0
	velocity.x = 0
	velocity.y = 0 
	restart = true
	#while restart == true:
	#Parpadeo del texto "GAME OVER"
		#yield(get_tree().create_timer(0.3), "timeout")						
	get_parent().get_node("ui/game_over").text = "GAME \nOVER"
	get_parent().get_node("ui/restart").text = "PRESS ENTER"
		#yield(get_tree().create_timer(0.7), "timeout")
		#get_parent().get_node("ui/game_over").text = ""
		#get_parent().get_node("ui/restart").text = "" """

func get_input(delta):
	if restart == true and Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
		
	if position.x != 149:
		game_over()
		
	if restart:
		return
	
	if is_on_floor():
		jumping = false
		running = true
		dead = false
		if Input.is_action_just_pressed("jump") and !shift:
			velocity.y -= max_jump_high
			
	if !is_on_floor():
		jumping = true
		running = false	
		dead = false
					
	if Input.is_action_just_released("jump"):
		gravity = 2000
		velocity.y += gravity * delta
	else:
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("shift"):
		shift = true
		jumping = false
		running = false
		
		gravity = 7500
		get_node("CollisionShape2D").scale.x *= 0.5
		get_node("CollisionShape2D").position.y += 4
	 
	if Input.is_action_just_released("shift"):
		shift = false
		gravity = 2000
		get_node("CollisionShape2D").scale.x /= 0.5
		get_node("CollisionShape2D").position.y -= 4

func animation():
	if running:
		get_node("running").visible = true
		get_node("jumping").visible = false
		get_node("shift").visible = false
		get_node("dead").visible = false
	
	if jumping:
		get_node("running").visible = false
		get_node("jumping").visible = true
		get_node("shift").visible = false
		get_node("dead").visible = false
	
	if shift:
		get_node("running").visible = false
		get_node("jumping").visible = false
		get_node("shift").visible = true
		get_node("dead").visible = false
	
	if dead == true:
		get_node("running").visible = false
		get_node("jumping").visible = false
		get_node("shift").visible = false
		get_node("dead").visible = true
		


