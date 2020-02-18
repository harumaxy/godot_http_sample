extends SceneTree

func _init():
	var done = false
	
	var socket = PacketPeerUDP.new()
	if(socket.listen(4242, "127.0.0.1") != OK):
		print("server error")
		done = true
	else:
		print("listening on port 4242 on localhost")
		
	while (!done):
		if(socket.get_available_packet_count() > 0):
			var data = socket.get_packet().get_string_from_utf8()
			if (data == "quit"):
				done = true
			else:
				print("recieve data is {%s}" %data)
	
	socket.close()
	print("Exit App")
	self.quit()
