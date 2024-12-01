extends Area2D

enum Function{WIN,CUTSCENE,SPAWN,SOUND,DIALOGUE,MECHANIC}
@export var function = Function.SPAWN
@export var nextLevel:int

@export var thisLevelWin = "res://Maps/level_1.tscn"

func _on_body_entered(body):
	if body.is_in_group("player"):
		match function:
			Function.WIN:
				Globals.victorious = true
				Globals.level_unlock = nextLevel
				SceneSwitcher.switch_scene(Globals.end_scene)
			Function.CUTSCENE:
				pass
			Function.SPAWN:
				pass
			Function.SOUND:
				pass
			Function.DIALOGUE:
				pass
			Function.MECHANIC:
				body.atMechanic = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		match function:
			Function.MECHANIC:
				body.atMechanic = false
