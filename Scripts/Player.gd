extends KinematicBody2D

const UP = Vector2.UP
var motion = Vector2.ZERO
var speed = 200

remote var remoteval = Vector2.ZERO


slave func setPos(pos: Vector2):
	self.position = pos

master func shutItDown():
	# クライアントの`shutDown()`を呼び出す。(自分を含む)
	rpc("shutDown")

sync func shutDown():
	get_tree().quit()

func _physics_process(delta):
	update_motion()
	if is_network_master():	
		move_and_slide(motion, UP)
		rpc_unreliable("setPos", self.position)
		
		if Input.is_key_pressed(KEY_Q):
			shutItDown()
		
		
	
func update_motion():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = 1
	elif not Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		motion.x = -1
	else:
		motion.x = 0
		
	if Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		motion.y = 1
	elif not Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_up"):
		motion.y = -1
	else:
		motion.y = 0
	
	motion = motion.normalized() * speed
