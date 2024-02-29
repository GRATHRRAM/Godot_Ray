extends CharacterBody2D

var Mouse_Line : bool = false
var Speed : float = 1.5
var Friction : float = 0.01
var timer : float = 0.5
var limit : Vector2 = Vector2(1000,1000)

func _process(delta):
	if timer > 0:
		timer -= delta
	queue_redraw()

func _physics_process(delta):
	velocity = lerp(velocity, Vector2.ZERO, Friction)	
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	#if velocity < Vector2(0.1, 0.1):
	#	velocity = Vector2.ZERO

func _draw():
	if Mouse_Line:
		draw_line(Vector2.ZERO, get_local_mouse_position(), Color(128,0,0,255),2,true)

func _input(event):
	if event.is_pressed():
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer < 0:
			Mouse_Line = !Mouse_Line
			timer = 0.5
			if !Mouse_Line:
				velocity = get_local_mouse_position() * Speed
				velocity *= -1
		if Input.is_action_pressed("midle_up") and $Camera2D.zoom < Vector2(4,4):
			$Camera2D.zoom *= 1.15
		if Input.is_action_pressed("midle_down") and $Camera2D.zoom > Vector2(0.1,0.1):
			$Camera2D.zoom *= 0.85
