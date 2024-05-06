@tool
extends Node2D

@onready var collision_shape = $CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer2D

@export var triggerable := true
@export var origin: Data.Side 

func _ready():
	if !triggerable:
		audio.stop()
		collision_shape.disabled = true

func _on_body_entered(body):
	if body.playable && triggerable:
		var scene = get_parent().leftScene if origin == Data.Side.Left else get_parent().rightScene
		Data.get_game_manager().switch_to_scene(scene, get_parent(), origin * -1, null)
