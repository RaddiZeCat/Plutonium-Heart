extends Area2D

enum Function{WIN,CUTSCENE,SPAWN,SOUND,DIALOGUE}
@export var function = Function.SPAWN

@export var thisLevelWin = "res://Maps/level_1.tscn"

func _on_body_entered(body):
	if body.is_in_group("player"):
		match function:
			Function.WIN:
				SceneSwitcher.switch_scene(thisLevelWin)
			Function.CUTSCENE:
				pass
			Function.SPAWN:
				pass
			Function.SOUND:
				pass
			Function.DIALOGUE:
				pass
