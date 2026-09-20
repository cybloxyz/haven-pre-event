extends Area2D

@onready var sprite = $AnimatedSprite2D
var got_hit = 0

func _ready() -> void:
	sprite.play("idle_star")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.is_dead:
			return

		if body.is_attacking:
			enemy_take_hit()
		else:
			if body.has_method("take_hit"):
				body.take_hit(global_position.x)

func enemy_take_hit() -> void:
	print("Musuh terkena serangan Player!")
	sprite.play("hit")
	got_hit += 1
	
	await sprite.animation_finished 
	
	sprite.play("idle_star")
	
	if got_hit >= 3:
		print("serangan ke musuh: ", got_hit)
		sprite.play("dead")
		
		await sprite.animation_finished
		queue_free()
	
		
