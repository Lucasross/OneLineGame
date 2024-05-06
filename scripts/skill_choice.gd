extends NinePatchRect

@onready var skill_level_label = $skill_level_label
@onready var texture_rect = $TextureRect
@onready var button_label = $button_label

@export var sprite: Texture
@export var label: String
@export var stat_type: Data.Stat

var player : Player

func _ready():
	texture_rect.texture = sprite
	button_label.text = label

func update(targetPlayer: Player):
	player = targetPlayer
	skill_level_label.text = str(PlayerData.get_stat(stat_type)) + "/40"

func _on_button_pressed():
	if PlayerData.skillPoint > 0 && PlayerData.get_stat(stat_type) < 40:
		player.increase_stat(stat_type)
		player.refresh_stat()
