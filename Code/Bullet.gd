extends Area2D

@export var speed = 1000
@export var damage = 1
@export var selfkill:bool = false

func _physics_process(delta):
	position += transform.x * speed * delta
	if selfkill == true:
		await get_tree().create_timer(0.2).timeout
		self.queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.hit(damage)
	queue_free()
