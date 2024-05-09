@tool
extends Area2D

class_name Monster

const MIN_POWER = 75
const MAX_POWER = 450
const DECREASE_PER_LEVEL = 0.2

signal onHealthChanged

@export var sprite: SpriteFrames:
	set(value):
		sprite = value
		if animated_sprite == null:
			return
		animated_sprite.sprite_frames = value
		if sprite != null:
			var size = sprite.get_frame_texture("idle", 0).get_height()
			animated_sprite.offset.y = (size / -2.0)
			get_node("HealthBar").position.y = -size - 5

@export_category("Data")
@export var rank: Rank
@export var level: int = 1
@export_range(0, 0.2) var health_regen := 0.025
var damage
var health
var current_health
var experience

@export_category("Visual")
@export_color_no_alpha var baseColor
@export_color_no_alpha var damageColor

@export_category("Audio")
@export var hitSound: AudioStream
@export var deathSound: AudioStream

@export_category("Options")
@export_range(0, 2) var height_to_distance_ratio := 0.8
@export_exp_easing var easing := 0.7
@export_range(0, 1) var potion_loot_chance := 0.05

#references
@onready var animated_sprite = $AnimatedSprite2D
@onready var damage_vfx_timer = $DamageVfxTimer
@onready var audio = $Audio
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_die = $AnimatedSprite2D_die

var player: Player

#misc
var prepared: bool = false

#enums
enum Rank {Small=-1, Normal, Elite, Boss}

func _ready():
	if Engine.is_editor_hint():
		sprite = sprite
		return
		
	sprite = sprite
	if animated_sprite != null:
		animated_sprite.play("idle")

func prepare():
	if prepared:
		return
	
	player = Data.get_game_manager().player
	health = MathCurve.get_health(level)
	damage = MathCurve.get_damage(level)
	experience = MathCurve.get_experience(level)
	current_health = health
	onHealthChanged.emit()
	prepared = true

func _process(delta):
	if Engine.is_editor_hint():
		return
	
	if player:
		animated_sprite.flip_h = true if get_direction(player) == Data.Side.Left else false
	if damage_vfx_timer.time_left > 0:
		var normalized_time = damage_vfx_timer.time_left / damage_vfx_timer.wait_time
		animated_sprite.self_modulate = lerp(baseColor, damageColor, normalized_time)
	if current_health < health:
		current_health += ceili(health * health_regen) * delta
		current_health = clamp(current_health, 0, health)
		onHealthChanged.emit()

func _on_player_entered(_body):
	current_health -= player.strenght
	onHealthChanged.emit()
	damage_vfx_timer.start()
	audio.stream = hitSound if current_health > 0 else deathSound
	audio.play()
	var direction = get_direction(player)
	var power = lerp(MIN_POWER, MAX_POWER, ease(get_percent_removed(player), easing))
	if current_health <= 0:
		die()
	player.damage(damage, {power = Vector2(power * direction, -power * height_to_distance_ratio), die = current_health <= 0})

func get_direction(body):
	if body != null:
		return 1 if body.global_position.x > global_position.x else -1
	else:
		return 1

func get_percent_removed(body):
	return float(damage) / body.max_health

func get_experience(player_level: int):
	if level < player_level:
		var level_dif = player_level - level
		var decrease_factor = (1 - (level_dif * DECREASE_PER_LEVEL))
		return experience * decrease_factor
	
	return experience

func die():
	player.increase_experience(get_experience(PlayerData.level))
	animation_player.play("die")
	animated_sprite_die.visible = true
	animated_sprite_die.play("explosion")
	var rng = RandomNumberGenerator.new()
	if rng.randf() < potion_loot_chance:
		PlayerData.potion_count += 1

func destroy():
	queue_free()
