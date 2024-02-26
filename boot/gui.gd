extends Control


func _on_gui_play_pressed():
	$gui_loading.visible = true
	get_tree().change_scene_to_file("res://Levels/Level0/Level0.tscn")
