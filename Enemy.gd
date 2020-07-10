extends Node2D

const BattleUnits = preload("res://BattleUnits.tres")

signal destroyed
signal end_turn

onready var hpLabel = $HPLabel
onready var animationPlayer = $AnimationPlayer

export(int) var max_hp = 25 setget set_max_hp
var hp = 0 setget set_hp
export(int) var damage_min = 1
export(int) var damage_max = 3

func attack():
	yield(get_tree().create_timer(0.4), "timeout")
	animationPlayer.play("Attack")
	yield(animationPlayer, "animation_finished")
	emit_signal("end_turn")

func set_hp(new_hp):
	hp = clamp(new_hp, 0, max_hp)
	hpLabel.text = str(hp)+" hp"
	
func set_max_hp(new_max):
	max_hp = new_max

func take_damage(amt):
	self.hp -= amt
	animationPlayer.play("Shake")
	yield(animationPlayer, "animation_finished")
	if(is_dead()):
		queue_free()
		emit_signal("destroyed")

func deal_damage():
	BattleUnits.Player.hp -= floor(rand_range(damage_min, damage_max))
	print("Deal damage!")

func is_dead():
	return hp <= 0

func _ready():
	BattleUnits.Enemy = self
	hp = max_hp
	hpLabel.text = str(hp)+" hp"
	
func _exit_tree():
	BattleUnits.Enemy = null
