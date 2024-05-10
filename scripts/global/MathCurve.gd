extends Node

class_name MathCurve

static func polynom3(a, b, c, d, x):
	return a * (x ** 4) + polynom2(b, c, d, x)

static func polynom2(a, b, c, x):
	return (a * x ** 2) + (b * x) + c

# 27.8x³ * 85.6x² * 250x + 50
static func get_required_experience(x: int) -> int:
	return int(polynom3(27.8, 85.4, 250, 50, x))
	
# 0.36x² * 7.56x + 50
static func get_experience(x: int) -> int:
	return int(polynom2(0.36, 7.56, 50, x))

# 1.6x² * 44x + 10
static func get_health(x: int) -> int:
	return int(polynom2(1.6, 44, 10, x))

# 0.43x² * 2.45x + 10
static func get_damage(x: int) -> int:
	return int(polynom2(0.43, 2.45, 10, x))
	
# 2.4x² * 2.3x + 20
static func get_stat_damage(x: int) -> int:
	return int(polynom2(2.4, 2.3, 20, x))
	
# 6.14x² * 100x + 320
static func get_stat_health(x: int) -> int:
	return int(polynom2(6.14, 100, 320, x))

# 0x² * 0.075x + 0
static func get_stat_speed(x: float) -> float:
	return 0.075 * x

# 0x² * 0.005x + 0
static func get_stat_regen(x: float) -> float:
	return 0.005 * x
