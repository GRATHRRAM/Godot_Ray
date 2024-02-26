extends CharacterBody2D

var Mouse_Line : bool = false
var Speed : float = 1
var Friction : float = 0.01
var timer = 0.5

func _process(delta):
	if timer > 0:
		timer -= delta
	queue_redraw()

func _physics_process(delta):
	velocity = lerp(velocity, Vector2.ZERO, Friction)
	print(velocity)
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())

func _draw():
	if Mouse_Line:
		draw_line(Vector2.ZERO, get_local_mouse_position(), Color(128,0,0,255),2,true)

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer < 0:
		Mouse_Line = !Mouse_Line
		timer = 0.5
		if !Mouse_Line:
			velocity = get_local_mouse_position() * Speed
			velocity *= -1
