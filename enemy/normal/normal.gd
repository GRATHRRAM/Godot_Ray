extends CharacterBody2D
var movement_speed: float = 200.0
var movement_target_position: Vector2 = Vector2(60.0,180.0)
var nav_cool_frames = 20

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	set_physics_process(false)
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	set_physics_process(true)
	navigation_agent.target_position = Vector2(0,0)

func _physics_process(_delta):
	if nav_cool_frames <= 0:
		if navigation_agent.is_navigation_finished():
			return
		
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()

		velocity = current_agent_position.direction_to(next_path_position) * movement_speed
		navigation_agent.set_velocity_forced(velocity)

func _process(_delta):
	if nav_cool_frames > 0:
		nav_cool_frames -= 1
	if nav_cool_frames <= 0:
		movement_target_position = get_parent().get_node("Player").get("position")
		navigation_agent.target_position = movement_target_position


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
