extends Control

func _ready():
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 4242)
	get_tree().network_peer = network
	
	# signal接続
	network.connect("connection_failed", self, "_on_connection_failed")
	get_tree().multiplayer.connect("network_peer_packet", self, "_on_packet_recieved")
		
func _on_packet_recieved(id, packet: PoolByteArray):
	$MessagesFromServer.text = packet.get_string_from_utf8()

func _on_connection_failed(error : String):
	$StatusLabel.text = error


func _on_ConnectButton_pressed():
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 4242)
	get_tree().network_peer = network
	# signal接続
	network.connect("connection_failed", self, "_on_connection_failed")

func _on_DisconnectButton_pressed():
	get_tree().network_peer = null



