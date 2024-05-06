extends TextureProgressBar

@export var label: Label

var player: Player

func init(targetPlayer):
	player = targetPlayer
	player.onExperienceChanged.connect(update)
	update()

func update():
	var required_experience = MathCurve.get_required_experience(PlayerData.level)
	value = float(PlayerData.experience) / required_experience
	label.text = str(int(PlayerData.experience)) + "/" + str(required_experience)
