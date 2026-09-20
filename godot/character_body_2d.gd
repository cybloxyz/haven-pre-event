extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -450.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_attacking: bool = false
var is_hit: bool = false
var is_dead: bool = false
var got_hit: int = 0

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta: float) -> void:
	if is_dead:
		return 

	if not is_on_floor():
		velocity += get_gravity() * delta

	if not is_hit:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
			sprite.flip_h = (direction < 0)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		handle_attack_input()

		if not is_attacking:
			update_animation(direction)

	move_and_slide()

func handle_attack_input() -> void:
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()

func attack() -> void:
	is_attacking = true
	print("Player menyerang")
	sprite.play("attack")
	
	await sprite.animation_finished
	
	is_attacking = false

func update_animation(direction: float) -> void:
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

func take_hit(enemy_position_x: float) -> void:
	if is_hit or is_dead:
		return
		
	got_hit += 1
	print("Player kena hit! Total hit: ", got_hit)
	
	if got_hit >= 3:
		dead()
		
		sprite.play("dead")
		
		await sprite.animation_finished
 		
		get_tree().reload_current_scene()

	is_hit = true
	is_attacking = false
	sprite.play("hit")
	
	var knockback_dir = -1.0 if enemy_position_x > global_position.x else -2.0
	velocity.x = knockback_dir * 50.0
	velocity.y = -100.0
	
	await sprite.animation_finished
	is_hit = false

func dead() -> void:
	is_dead = true
	velocity = Vector2.ZERO 
	sprite.play("dead")
	
	await sprite.animation_finished 
	queue_free() 
