extends TextureButton

@export var container: Control

func _on_pressed():
	container.visible = false
