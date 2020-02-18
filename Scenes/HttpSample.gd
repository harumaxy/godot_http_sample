extends Control

func _ready():
#	$HTTPRequest.connect("request_completed", self, "_on_HTTPRequest_request_completed")
	pass

func _on_Button_pressed():
	$HTTPRequest.request(
		"https://jsonplaceholder.typicode.com/todos/1",
		PoolStringArray([]),
		false
	)

func _on_HTTPRequest_request_completed(result, response_code: int, headers, body: PoolByteArray):
	if(response_code == 200):
		$CenterContainer/Label.text = body.get_string_from_utf8()




