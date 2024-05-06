extends TextureProgressBar

@export var label: Label

var player: Player

func init(targetPlayer):
	player = targetPlayer
	player.onHealthChanged.connect(update)
	update()

func update():
	value = float(player.health) / player.max_health
	label.text = str(int(player.health)) + "/" + str(player.max_health)
