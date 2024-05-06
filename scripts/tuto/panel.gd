extends Area2D

@export_multiline var panel_text = "Here your message"
@onready var label = $Label

func _ready():
	label.text = panel_text

func _on_body_entered(_body):
	label.visible = true

func _on_body_exited(_body):
	label.visible = false
