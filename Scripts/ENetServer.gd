extends Control


func _ready():
	# サーバー作成
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242, 2)
	
	# SceneTreeにセット
	var sceneTree = get_tree() as SceneTree
	sceneTree.network_peer = network
	
	# signalをメソッドに接続
	network.connect("peer_connected", self, "_peer_connected")
	network.connect("peer_disconnected", self, "_peer_disconnected")
	
	

	


func _peer_connected(id: int):
	var num_of_client = get_tree().get_network_connected_peers().size() as int
	$UserCountLabel.text = "Total User: %d" %num_of_client
	$UserIdLabel.text =  "uid : %d has connected!" %id
	
func _peer_disconnected(id: int):
	var num_of_client = get_tree().get_network_connected_peers().size() as int
	$UserCountLabel.text = "Total User: %d" %num_of_client
	$UserIdLabel.text =  "uid : %d has disconnected!" %id


func _on_SendButton_pressed():
	var sendText = $LineEdit.text
	get_tree().multiplayer.send_bytes(sendText.to_utf8())




func _on_LineEdit_text_entered(new_text):
	_on_SendButton_pressed()
