extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var damage_receiver: DamageReceiver = $DamageReceiver
@export var knockback_intensity: float
enum State {IDLE, DESTORYED}

var height:float = 0.0
var height_speed:float = 0.0
var state = State.IDLE
var velocity := Vector2.ZERO
const GRAVITY:float = 600.0

func _ready() -> void:
	damage_receiver.damage_received.connect(_on_receive_damage.bind())

func _process(delta: float) -> void:
	position += velocity * delta
	sprite_2d.position = -Vector2.UP * height
	_handle_air_time(delta)

func _on_receive_damage(damage: int, direction: Vector2) -> void:
	if state == State.IDLE:
		sprite_2d.frame = 1
		height_speed = knockback_intensity
		state = State.DESTORYED
		velocity = direction * knockback_intensity

func _handle_air_time(delta: float) -> void:
	if state == State.DESTORYED:
		height += height_speed * delta
		if height < 0:
			height = 0
			queue_free()
		else:
			height_speed -= GRAVITY * delta
