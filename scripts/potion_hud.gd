extends Control

signal on_potion_request

@onready var label = $PixelScaler/TextureButton/Label
@onready var timer = $PixelScaler/TextureButton/Timer
@onready var progress_bar = $PixelScaler/TextureButton/TextureProgressBar

func _ready():
	PlayerData.on_potion_changed.connect(update)
	update()
	
func _process(_delta):
	progress_bar.value = timer.time_left

func _input(event):
	if event.is_action_pressed("potion_request"):
		_on_button_pressed()

func update():
	visible = PlayerData.potion_count != -1
	label.text = str(PlayerData.potion_count)

func _on_button_pressed():
	if timer.time_left <= 0 && PlayerData.potion_count <= 0:
		return
		
	timer.start()
	on_potion_request.emit()
