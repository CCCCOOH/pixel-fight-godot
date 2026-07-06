extends Node2D

@export var player: CharacterBody2D
@export var camera: Camera2D

func _process(_delta: float) -> void:
	if player.position.x > camera.position.x:
		camera.position.x = player.position.x
