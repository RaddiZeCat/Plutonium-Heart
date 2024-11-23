extends Sprite2D

@onready var scene = get_tree().get_root()
@onready var mine = $"."
@export var explosion:PackedScene
@export var friendly = false

func _ready():
	if friendly == true:
		mine.set_frame(1)
	elif friendly == false:
		return
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if friendly == false:
			detonate()
	elif body.is_in_group("enemy"):
		if friendly == true:
			detonate()

func detonate():
	var i = explosion.instantiate()
	scene.add_child(i)
	i.transform = $".".global_transform
	queue_free()
