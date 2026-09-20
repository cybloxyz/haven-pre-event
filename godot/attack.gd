extends Area2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "attacked":
		var enemy = area.get_parent()
		
		if enemy and enemy.has_method("enemy_take_hit"):
			enemy.enemy_ke_hit()
