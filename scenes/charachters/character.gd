extends CharacterBody2D

@export var heath : int 
@export var damage: int
@export var speed: float
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var character_sprite: Sprite2D = $CharacterSprite

enum State {IDLE, WALK, ATTACK}

var state = State.IDLE

func _process(_delta: float) -> void:
	handle_input()
	handle_movement()
	handle_animations()
	handle_sprite()
	move_and_slide()

func handle_movement() -> void:
	if can_walk():
		if velocity.length() == 0:
			state = State.IDLE
		else:
			state = State.WALK
	else:
		velocity = Vector2.ZERO

func handle_input() -> void:
	var direction = Input.get_vector("left", 'right', 'up', 'down')
	velocity = direction * speed
	if can_attack() && Input.is_action_just_pressed("attack"):
		state = State.ATTACK

func handle_animations() -> void:
	if state == State.IDLE:
		animation_player.play('idle')
	elif state == State.WALK:
		animation_player.play("walk")
	elif state == State.ATTACK:
		animation_player.play("punch")
		
func handle_sprite() -> void:
	if velocity.x < 0:
		character_sprite.flip_h = true
	elif velocity.x > 0:
		character_sprite.flip_h = false
		
func can_attack() -> bool:
	return state == State.IDLE or state == State.WALK
	
func can_walk() -> bool:
	return state == State.IDLE or state == State.WALK

func on_action_complete() -> void:
	state = State.IDLE
