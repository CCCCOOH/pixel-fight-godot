extends CharacterBody2D

@export var heath : int 
@export var damage: int
@export var speed: float
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var character_sprite: Sprite2D = $CharacterSprite

enum State {IDLE, WALK}

var state = State.IDLE

func _process(_delta: float) -> void:
	handle_input()
	handle_movement()
	handle_animations()
	handle_sprite()
	move_and_slide()

func handle_movement() -> void:
	if velocity.length() == 0:
		state = State.IDLE
	else:
		state = State.WALK

func handle_input() -> void:
	var direction = Input.get_vector("left", 'right', 'up', 'down')
	velocity = direction * speed

func handle_animations() -> void:
	if state == State.IDLE:
		animation_player.play('idle')
	elif state == State.WALK:
		animation_player.play("walk")
		
func handle_sprite() -> void:
	if velocity.x < 0:
		character_sprite.flip_h = true
	else:
		character_sprite.flip_h = false
		
