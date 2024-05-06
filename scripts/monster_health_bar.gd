extends TextureProgressBar

@export var monster: Monster
@onready var label = $Label

func _ready():
	monster.onHealthChanged.connect(update)
	label.text = str(monster.level)
	
func update():
	value = float(monster.current_health) / monster.health
