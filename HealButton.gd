extends "res://Button.gd"

func _on_pressed():
	var player = BattleUnits.Player
	if(player.mp >= 8):
		player.ap -= 1
		player.hp += 5
		player.mp -= 8
