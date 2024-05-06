extends TextureButton

@export var container: Control

var player: Player

func init(targetPlayer):
	player = targetPlayer
	player.onSkillPointChanged.connect(update)
	update()

func update():
	container.visible = PlayerData.skillPoint > 0
