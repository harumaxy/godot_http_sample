extends Node2D

var player_template = preload("res://Scenes/Player.tscn")

func _ready():
	var thisPlayer = player_template.instance() as KinematicBody2D
	var this_uid = get_tree().get_network_unique_id()
	thisPlayer.name = (str(this_uid))
	thisPlayer.set_network_master(this_uid)
	if(get_tree().multiplayer.is_network_server()):
		thisPlayer.position = Vector2(400, 400)	
	add_child(thisPlayer)
	
	var otherPlayer = player_template.instance() as KinematicBody2D
	otherPlayer.name = str(globals.other_player_id)
	otherPlayer.set_network_master(globals.other_player_id)
	add_child(otherPlayer)
