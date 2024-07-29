extends Area2D

@export var speed = 1000
@export var damage = 1

func _physics_process(delta):
	position += transform.x * speed * delta



func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.hit(damage)
		body.queue_free()
	queue_free()
