extends Button

func _ready() -> void:
	# Menghubungkan sinyal pressed secara otomatis saat node siap
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	Global.map_count = 0
	get_tree().change_scene_to_file("res://main.tscn")
