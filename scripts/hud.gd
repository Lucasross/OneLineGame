extends CanvasLayer

@export var health_bar: TextureProgressBar
@export var experience_bar: TextureProgressBar
@export var levelup_button: TextureButton
@export var skill_view : Control

@onready var player: Player = %Player

func _ready():
	health_bar.init(player)
	experience_bar.init(player)
	levelup_button.init(player)
	skill_view.init(player)


func _on_level_button_pressed():
	skill_view.visible = true


func _on_avatar_button_pressed():
	skill_view.visible = !skill_view.visible