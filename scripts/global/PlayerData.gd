extends Node

signal on_potion_changed

var playerData = PlayerDataSave.new()

var experience: 
	get:
		return playerData.experience
	set(value):
		playerData.experience = value
		save_player()
var level: int = 1 :
	get:
		return playerData.level
	set(value):
		playerData.level = value
		save_player()
var skillPoint: int = 0 :
	get:
		return playerData.skillPoint
	set(value):
		playerData.skillPoint = value
		save_player()
var potion_count: int = 0:
	get:
		return playerData.potion_count
	set(value):
		playerData.potion_count = value
		on_potion_changed.emit()
		save_player()
func get_stat(stat: Data.Stat):
	return playerData.stats[stat]
func inc_stat(stat: Data.Stat, value: int):
	playerData.stats[stat] += value
	save_player()

func save_player():
	var save_file = FileAccess.open("user://player.save", FileAccess.WRITE)
	var json_string = JSON.stringify(playerData.save())
	save_file.store_line(json_string)
	
func _ready():
	if FileAccess.file_exists("user://player.save"):
		load_player()
	#pass

func load_player():
	var save_file = FileAccess.open("user://player.save", FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
		
	var save_data = json.get_data()
	playerData.load(save_data)
