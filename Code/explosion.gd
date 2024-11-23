extends Sprite2D

@onready var animator = $AnimationPlayer
@onready var area = $Area2D
@onready var damage = 5

func _ready():
	animator.play("explosion")

func _on_animation_player_animation_finished(anim_name):
	queue_free()

func _on_area_2d_body_entered(body):
	body.hit(damage)
