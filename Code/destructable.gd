@tool
extends Sprite2D

@onready var image = $"."
@onready var eyes = $Area2D

enum State{BENCH,REDLIGHT,STREETLIGHTON,STREETLIGHTOFF,BIN,TREE}
@export var state = State.BENCH

func _ready():
	match state:
		State.BENCH:
			image.set_frame(0)
		State.REDLIGHT:
			image.set_frame(2)
		State.STREETLIGHTON:
			image.set_frame(4)
		State.STREETLIGHTOFF:
			image.set_frame(5)
		State.BIN:
			image.set_frame(7)
		State.TREE:
			image.set_frame(9)

func _on_area_2d_body_entered(body):
	match state:
		State.BENCH:
			image.set_frame(1)
		State.REDLIGHT:
			image.set_frame(3)
		State.STREETLIGHTON:
			image.set_frame(6)
		State.STREETLIGHTOFF:
			image.set_frame(6)
		State.BIN:
			image.set_frame(8)
		State.TREE:
			image.set_frame(10)
	eyes.set_deferred("monitoring",false)
