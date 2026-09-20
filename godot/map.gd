extends Area2D

@onready var map: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	map.play("idle")

func _on_body_entered(body: Node2D) -> void:
	# Cek apakah yang menyentuh item adalah Player
	if body is CharacterBody2D:
		# 1. Tambah jumlah peta di singleton Global
		Global.map_count += 1
		print("Peta berhasil diambil! Total: ", Global.map_count)
		
		# 2. Matikan collision agar tidak terpicu 2x saat animasi jalan
		$CollisionShape2D.set_deferred("disabled", true)
		
		# 3. Putar animasi folding
		map.play("folding")
		await map.animation_finished
		
		# 4. Hapus peta dari scene
		queue_free()
