extends Sprite2D

@export var energy = 5
@onready var animator = $AnimationPlayer

func _ready():
	animator.play("bobb")

func _on_area_2d_body_entered(body):
	if  body.is_in_group("player"):
		body.heal(energy)
		queue_free()
