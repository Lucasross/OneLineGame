extends Area2D

@export_multiline var panel_text = "Here your message"
@onready var label = $Label

@export_category("Features")
@export var give_potion: bool = false

func _ready():
	label.text = panel_text

func _on_body_entered(_body):
	label.visible = true
	do_features()

func _on_body_exited(_body):
	label.visible = false

func do_features():
	if give_potion && PlayerData.potion_count == -1:
		PlayerData.potion_count = 2
