extends Area2D

enum Function{WIN,CUTSCENE,SPAWN,SOUND,DIALOGUE}

func _on_body_entered(body):
	if body.is_in_group("player"):
		pass
