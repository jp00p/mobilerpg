extends "res://Button.gd"

const Slash = preload("res://Slash.tscn")

func _on_pressed():
	
	var enemy = BattleUnits.Enemy
	var player = BattleUnits.Player
	
	if enemy != null and player != null:
		enemy.take_damage(4)
		create_slash(enemy.global_position)
		player.mp += 2
		player.ap -= 1
		
func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
