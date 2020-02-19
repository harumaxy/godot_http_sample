extends Control

remote var remoteStr = ""
remotesync var remoteSyncStr = ""


func _ready():
	get_tree().connect("network_peer_connected", self, "_on_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_disconnected")

func _process(delta):
	$VBoxContainer/RemoteRandomLabel.text = remoteStr
	$VBoxContainer/RemotesyncRandomLabel.text = remoteSyncStr
	
func _on_connected(id):
	if get_tree().is_network_server():
		$VBoxContainer/RoleLabel.text = "Server"
	else:
		$VBoxContainer/RoleLabel.text = "Client"
	$VBoxContainer/ConnectCount.text = str(get_tree().multiplayer.get_network_connected_peers().size())

func _on_disconnected():
	$VBoxContainer/RoleLabel.text = ""
	$VBoxContainer/ConnectCount.text = ""
	

func _on_Server_pressed():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242, 2)
	get_tree().network_peer = network


func _on_Client_pressed():
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 4242)
	get_tree().network_peer = network


func _on_Disconnect_pressed():
	var network = get_tree().network_peer as NetworkedMultiplayerENet
	network.close_connection()
	$VBoxContainer/RoleLabel.text = ""
	$VBoxContainer/ConnectCount.text = ""


func _on_Random_pressed():
	var randstr = str(randi() % 10)
	rset("remoteStr", "remote: %s" %randstr)


func _on_RemoteSyncRandom_pressed():
	var randstr = str(randi() % 10)
	
