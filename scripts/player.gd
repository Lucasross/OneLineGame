extends CharacterBody2D

class_name Player

signal onHealthChanged
signal onExperienceChanged
signal onLevelChanged
signal onSkillPointChanged

const SPEED = 100.0

@export_category("Base")
@export_range(0, 0.2) var base_regen := 0.001
@export var base_speed: float = 1

@export_category("Options")
@export var playable := true

# Statistics
var max_health = 0
var health = max_health :
	get: 
		return health
	set(value):
		health = value
		onHealthChanged.emit()
var strenght = 0
var speed = 0
var regen = 0

# References
@onready var hit_timer = $HitTimer
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var animation_player_levelup = $LevelUp/AnimationPlayer_levelup

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	# Stats setup
	refresh_stat()
	
	# Health refresh
	health = max_health
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if !playable:
		direction = 0
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animation
	if playable:
		if !is_on_floor():
			animated_sprite.play("damaged")
		elif direction != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
	
	# Update movement on x axis
	if is_on_floor() && hit_timer.time_left == 0:
		if direction:
			velocity.x = direction * SPEED * (speed + base_speed)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if health < max_health:
		health += ceili(max_health * (regen + base_regen)) * delta
		health = clamp(health, 0, max_health)
	
	move_and_slide()

func damage(hitdamage, fightResult):
	if hit_timer.time_left == 0:
		health -= hitdamage
		hit_timer.start()
		if health <= 0:
			velocity = fightResult.power * 2
			playable = false
			animation_player.play("die")
		else:
			if !fightResult.die:
				velocity = fightResult.power

func increase_experience(monsterExperience):
	PlayerData.experience += monsterExperience
	if PlayerData.experience >= MathCurve.get_required_experience(PlayerData.level):
		on_level_up()
	onExperienceChanged.emit()
			
func on_level_up():
	PlayerData.level += 1
	PlayerData.experience -= MathCurve.get_required_experience(PlayerData.level - 1)
	health = max_health
	PlayerData.skillPoint += 2
	animation_player_levelup.play("level_up")
	onLevelChanged.emit()
	onSkillPointChanged.emit()
	
func increase_stat(stat_type: Data.Stat):
	PlayerData.inc_stat(stat_type, 1)
	PlayerData.skillPoint -= 1
	onSkillPointChanged.emit()

func refresh_stat():
	strenght = MathCurve.get_stat_damage(PlayerData.get_stat(Data.Stat.Damage))
	max_health = MathCurve.get_stat_health(PlayerData.get_stat(Data.Stat.Health))
	speed = MathCurve.get_stat_speed(PlayerData.get_stat(Data.Stat.Speed))
	regen = MathCurve.get_stat_regen(PlayerData.get_stat(Data.Stat.Regen))

func restart_stage():
	Data.get_game_manager().restart_stage()

func reset_player():
	health = max_health
	velocity = Vector2.ZERO
	playable = true
	animation_player.play("RESET")
