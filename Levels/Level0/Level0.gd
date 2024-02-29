extends Node2D

@onready var wall_ast : PackedScene = preload("res://Levels/Level0/wall.tscn") 

func _ready():
	randomize()
	Gen_world()
	pass

func Gen_world():
	for i in 100:
		var wall = wall_ast.instantiate()
		var _scale : int = randi_range(1, 10)
		while true:
			wall.position = Vector2(randi_range(-10000,10000),randi_range(-10000,10000))
			if wall.position < Vector2(-100,-100) or wall.position > Vector2(100,100):
				break
		wall.scale = Vector2(_scale,_scale)
		add_child(wall)
