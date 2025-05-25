extends Node2D


onready var timer = get_node("Timer")
onready var cloud_timer = get_node("cloud_timer")

onready var cactus1 = get_node("cactus1")
onready var  cactus1_packed = preload("res://cactus1.tscn")
onready var cactus1_instance = cactus1_packed.instance()
var cactus1_array = []

onready var cactus2 = get_node("cactus2")
onready var  cactus2_packed = preload("res://cactus2.tscn")
onready var cactus2_instance = cactus2_packed.instance()
var cactus2_array = []

onready var cactus3 = get_node("cactus3")
onready var  cactus3_packed = preload("res://cactus3.tscn")
onready var cactus3_instance = cactus3_packed.instance()
var cactus3_array = []

onready var bird = get_node("bird")
onready var  bird_packed = preload("res://bird.tscn")
onready var bird_instance = bird_packed.instance()
var bird_array = []

onready var cloud = get_node("cloud")
onready var  cloud_packed = preload("res://cloud.tscn")
onready var cloud_instance = cloud_packed.instance()
var cloud_array = []

var cactus = 1
var timer_out: bool
var speed = 10
var points = 0
var cactus_scale = 2
var bird_high = 320
var cloud_high = 104


func _physics_process(delta):
	get_node("ui/points").text = "POINTS: " + str(points)
		
	for cactus_1 in cactus1_array:
		cactus_1.position.x -= speed * delta * 60
		if cactus_1.position.x < -64:
			points += 1
			speed += 0.1
			cactus_1.queue_free()
			cactus1_array.erase(cactus_1)
				
	for cactus_2 in cactus2_array:
		cactus_2.position.x -= speed
		if cactus_2.position.x < -64:
			points += 1
			speed += 0.1
			cactus_2.queue_free()
			cactus2_array.erase(cactus_2)
			
	for cactus_3 in cactus3_array:
		cactus_3.position.x -= speed
		if cactus_3.position.x < -64:
			points += 1
			speed += 0.1
			cactus_3.queue_free()
			cactus3_array.erase(cactus_3)
		
	for bird in bird_array:
		bird.position.x -= speed
		if bird.position.x < -64:
			points += 1
			speed += 0.1
			bird.queue_free()
			bird_array.erase(bird)
	
	for cloud in cloud_array:
		cloud.playing = true
		cloud.position.x -= speed/2
		if cloud.position.x < -64:
			cloud.queue_free()
			cloud_array.erase(cloud)
				
func _ready():
	if cactus == 1:
		generate_cactus1_instance()
	if cactus == 2:
		generate_cactus2_instance()
	if cactus == 3:
		generate_cactus3_instance()
	if cactus >= 4:
		generate_bird_instance()
	generate_cloud_instance()
	

func _on_Timer_timeout():
	if get_node("player").restart == false:
		print("Time " + str(timer.wait_time))
		var random_timer = RandomNumberGenerator.new()
		random_timer.randomize()
		timer.wait_time = random_timer.randi_range(1, 3)
	
		print("Cactus " + str(cactus))
		var random_cactus = RandomNumberGenerator.new()
		random_cactus.randomize()
		if points < 10:
			cactus = random_cactus.randi_range(1, 3)
		else:
			cactus = random_cactus.randi_range(1, 5)
	
		print("Scale " + str(cactus_scale))
		var random_scale = RandomNumberGenerator.new()
		random_scale.randomize()
		cactus_scale = random_scale.randi_range(1, 2)
		
		var random_bird = RandomNumberGenerator.new()
		random_bird.randomize()
		bird_high = random_bird.randi_range(432, 288)
	
	if cactus == 1:
		generate_cactus1_instance()
	if cactus == 2:
		generate_cactus2_instance()
	if cactus == 3:
		generate_cactus3_instance()
	if cactus >= 4:
		generate_bird_instance()
	
func generate_cactus1_instance():
	cactus1_instance = cactus1_packed.instance()
	cactus1_array.append(cactus1_instance)
	add_child(cactus1_instance)
	cactus1_instance.position = cactus1.position
	cactus1_instance.scale = cactus1.scale
	cactus1_instance.z_index = -1
	if cactus_scale == 1:
		cactus1_instance.scale = Vector2(4, 4)

func generate_cactus2_instance():
	cactus2_instance = cactus2_packed.instance()
	cactus2_array.append(cactus2_instance)
	add_child(cactus2_instance)
	cactus2_instance.position = cactus2.position
	cactus2_instance.scale = cactus2.scale
	cactus2_instance.z_index = -1
	if cactus_scale == 1:
		cactus2_instance.scale = Vector2(4, 4)
	
func generate_cactus3_instance():
	cactus3_instance = cactus3_packed.instance()
	cactus3_array.append(cactus3_instance)
	add_child(cactus3_instance)
	cactus3_instance.position = cactus3.position
	cactus3_instance.scale = cactus3.scale
	cactus3_instance.z_index = -1
	if cactus_scale == 1:
		cactus3_instance.scale = Vector2(4, 4)
	
func generate_bird_instance():
	bird_instance = bird_packed.instance()
	bird_array.append(bird_instance)
	add_child(bird_instance)
	bird_instance.position.x = bird.position.x
	bird_instance.position.y = bird_high
	bird_instance.scale = bird.scale
	bird_instance.z_index = -1

func generate_cloud_instance():
	cloud_instance = cloud_packed.instance()
	cloud_array.append(cloud_instance)
	add_child(cloud_instance)
	cloud_instance.position.x = cloud.position.x
	cloud_instance.position.y = cloud_high
	cloud_instance.scale = cloud.scale
	cloud_instance.z_index = -1
	if cactus_scale == 1:
		cloud_instance.scale = Vector2(4, 4)

func _on_cloud_timer_timeout():
	generate_cloud_instance()
	print("Cloud " + str(cloud_timer.wait_time))
	var random_cloud_timer = RandomNumberGenerator.new()
	random_cloud_timer.randomize()
	cloud_timer.wait_time = random_cloud_timer.randi_range(3, 6)
	
	var random_cloud_high = RandomNumberGenerator.new()
	random_cloud_high.randomize()
	cloud_high = random_cloud_high.randi_range(48, 224)
	
	
