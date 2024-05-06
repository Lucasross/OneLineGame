extends Control


var player : Player

@onready var damage_skill_choice = $PixelScaler/NinePatchRect/HBoxContainer/DamageSkillChoice
@onready var health_skill_choice = $PixelScaler/NinePatchRect/HBoxContainer/HealthSkillChoice
@onready var speed_skill_choice = $PixelScaler/NinePatchRect/HBoxContainer/SpeedSkillChoice
@onready var regen_skill_choice = $PixelScaler/NinePatchRect/HBoxContainer/RegenSkillChoice

@onready var skill_label = $PixelScaler/NinePatchRect/Label

func init(targetPlayer: Player):
	player = targetPlayer
	player.onSkillPointChanged.connect(_on_visibility_changed)
	_on_visibility_changed()

func _on_visibility_changed():
	if player:
		skill_label.text = "Skill Point: " + str(PlayerData.skillPoint)
		damage_skill_choice.update(player)
		health_skill_choice.update(player)
		speed_skill_choice.update(player)
		regen_skill_choice.update(player)
