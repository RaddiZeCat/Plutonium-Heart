extends Sprite2D

@onready var hole = $"."
@onready var timer = $Timer

func _on_timer_timeout():
	queue_free()
