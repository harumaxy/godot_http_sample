extends Control

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")


func _on_HostGame_pressed():
	print("Hosting Network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(4242, 2)		# 2人用のサーバーを、4242 portで解放
	if res != OK:
		print("Error creating server")
		return
	
	$VBoxContainer/HostGame.disabled = true
	$VBoxContainer/JoinGame.hide()
	get_tree().network_peer = host
	
func _on_JoinGame_pressed():
	print("Joining network")
	var host = NetworkedMultiplayerENet.new()
	host.create_client("127.0.0.1", 4242)
	get_tree().network_peer = host
	
	$VBoxContainer/HostGame.hide()
	$VBoxContainer/JoinGame.disabled = true

func _player_connected(id: int):
	print("player %d connected to server!" %id)
	globals.other_player_id = id 
	# Game on!
	var game = preload("res://Scenes/Game.tscn").instance()
	get_tree().root.add_child(game)
	hide()
