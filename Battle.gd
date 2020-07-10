extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export(Array, PackedScene) var enemies = []

onready var battleActionButtons = $UI/BattleActionButtons
onready var transitions = $Transitions
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyStartPosition = $EnemyPosition

func set_battle_buttons_active(state):
	var childs = battleActionButtons.get_children()
	for b in childs:
		b.disabled = !state

func _ready():
	randomize()
	start_player_turn()
	nextRoomButton.hide()
	var enemy = BattleUnits.Enemy
	if(enemy != null):
		enemy.connect("destroyed", self, "_on_enemy_destroyed")

func start_enemy_turn():
	print("Enemy turn")
	var enemy = BattleUnits.Enemy
	set_battle_buttons_active(false)
	if(enemy != null):
		enemy.attack()
		yield(enemy, "end_turn")
	start_player_turn()

	
func start_player_turn():
	print("Player turn")
	set_battle_buttons_active(true)
	var playerStats = BattleUnits.Player
	playerStats.ap = playerStats.max_ap
	yield(playerStats, "end_turn")
	start_enemy_turn()

func create_new_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()	
	var enemy = Enemy.instance()
	enemyStartPosition.add_child(enemy)
	enemy.connect("destroyed", self, "_on_enemy_destroyed")


func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	transitions.play("FadeInOut")
	set_battle_buttons_active(false)
	yield(transitions, "animation_finished")
	create_new_enemy()
	start_player_turn()

func _on_enemy_destroyed():
	print("Destroyed enemy!")
	nextRoomButton.show()
	set_battle_buttons_active(false)
