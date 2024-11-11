extends Area2D

export var speed = 450
export var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_area_entered")
	pass # Replace with function body.

func _process(delta):
	position.y += speed * delta
	if position.y > 2000:
		queue_free()

func _on_area_entered(area):
	if area.name == "Player":
		area.add_damage(damage)
		queue_free()
