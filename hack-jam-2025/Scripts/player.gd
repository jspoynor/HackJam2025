extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var dash_length: float = 100.0
@export var dash_position: Node2D
@export var player_sprite: Sprite2D
@export var game_scene: Node

func _ready():
	dash_position.position.x = dash_length
	if not game_scene:
		game_scene = self

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction = Input.get_axis("Player Left", "Player Right")
	var y_direction = Input.get_axis("Player Up", "Player Down")
	
		
	if Input.is_action_just_pressed("dash"):
		var dash_buildup_time = 0.1
		var place_to_dash = dash_position.global_position
		
		start_teleport(place_to_dash, dash_buildup_time)
	else:
		
		
		if x_direction:
			velocity.x = x_direction * SPEED
		else:
			velocity.x = 0
		
		if y_direction:
			velocity.y = y_direction * SPEED
		else:
			velocity.y = 0
	
	move_and_slide()

func start_teleport(place_to_dash: Vector2, buildup_time: float):
		await get_tree().create_timer(buildup_time).timeout
		position = place_to_dash
