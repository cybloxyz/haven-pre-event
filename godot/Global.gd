extends Node

var map_count: int = 0:
	set(value):
		map_count = value
		if map_count >= 5:
			get_tree().change_scene_to_file("res://WinScreen.tscn")
