extends Control

@onready var count_label: Label = $CountLabel

func _process(_delta: float) -> void:
	# Terus perbarui teks sesuai nilai Global.map_count
	count_label.text = str(Global.map_count)
 
