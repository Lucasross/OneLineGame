@tool
extends Node2D

const monster_scene = preload("res://scenes/monster.tscn")

@export var spawn_btn: bool :
	set(value):
		if get_child_count() > 0:
			despawn()
		spawn()
		
@export var despawn_btn: bool :
	set(value):
		despawn()

@export_category("Data")
@export var random : bool = false
@export var quantity : int = 1
@export var spacing : int = 32
@export var level_range : Vector2i #inclusive
@export var possibilities : Array[SpriteFrames] = []

func _ready():
	if !random:
		return
		
	if get_child_count() > 0:
		despawn()
	spawn()

func spawn():
	for i in quantity:
		var monster = monster_scene.instantiate()
		monster.sprite = possibilities.pick_random()
		monster.position.x += i * spacing
		var rng = RandomNumberGenerator.new()
		monster.level = rng.randi_range(level_range.x, level_range.y)
		monster.name = monster.sprite.resource_name + " (lv." + str(monster.level) + ")"
		monster.prepare()
		add_child(monster)
		monster.owner = get_parent()
		
func despawn():
	for n in get_children():
		remove_child(n)
		n.queue_free()
