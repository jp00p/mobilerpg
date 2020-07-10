extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export var max_hp = 25
onready var hp = max_hp setget set_hp

export var max_ap = 3
onready var ap = max_ap setget set_ap

export var max_mp = 10
onready var mp = max_mp setget set_mp

signal end_turn
signal hp_changed(value)
signal ap_changed(value)
signal mp_changed(value)

func set_hp(new_hp):
	hp = clamp(new_hp, 0, max_hp)
	emit_signal("hp_changed", hp)

func set_mp(new_mp):
	mp = clamp(new_mp, 0, max_hp)
	emit_signal("mp_changed", mp)
	
func set_ap(new_ap):
	ap = clamp(new_ap, 0, max_ap)
	emit_signal("ap_changed", ap)
	if(ap <= 0):
		emit_signal("end_turn")

func _ready():
	BattleUnits.Player = self
	
func _exit_tree():
	BattleUnits.Player = null
