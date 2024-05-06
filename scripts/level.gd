extends Node2D

@export var leftPortal: Area2D
@export var leftScene: Data.Scene
@export var rightPortal: Area2D
@export var rightScene: Data.Scene

func get_portal(side: Data.Side):
	return leftPortal if side == Data.Side.Left else rightPortal
