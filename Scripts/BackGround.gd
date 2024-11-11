extends Node2D


const Move_speed = 500
const offset = 64

onready var top = $TopBackGround
onready var botton = $BottomBackGround

var top_position
var botom_position

func _ready():
	top_position = top.position.y
	botom_position = get_viewport_rect().size.y

func _process(delta):
	top.position.y += Move_speed * delta
	botton.position.y += Move_speed * delta
	if top.position.y >= botom_position + offset:
		top.position.y = top_position
	elif botton.position.y >= botom_position + offset:
		botton.position.y = top_position

