extends KinematicBody2D


const SPEED = 500
export(PackedScene) var projectile

export var health = 50
onready var sprite = $Sprite
onready var death_timer = $DeathTimer
onready var timer = $Timer
onready var audio = $Audio

var screen_size
var half_sprite_size
var can_shoot = true
var dead = false

func _ready():
	screen_size = get_viewport_rect().size.x
	half_sprite_size = sprite.texture.get_width() * scale.x / 2
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
	elif Input.is_action_pressed("right"):
		position.x += SPEED * delta
	
	if can_shoot and Input.is_action_pressed("shoot"):
		can_shoot= false
		var new_projectile = projectile.instance()
		get_parent().add_child(new_projectile)
		new_projectile.position = position
		timer.start()
		audio.play()
	
	position.x = clamp(position.x, 0 + half_sprite_size, screen_size - half_sprite_size)


func _on_Timer_timeout():
	can_shoot = true

func add_damage(damage):
	if dead:
		return
	health -= damage
	if health <= 0:
		dead = true
		health = 0
		death_timer.start()
		set_process(false)
		sprite.queue_free()
	

func _on_DeathTimer_timeout():
	get_tree().reload_current_scene()
