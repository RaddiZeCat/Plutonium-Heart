extends Sprite2D
@onready var zone = $Area2D
@onready var box = $"."
@onready var text = $RichTextLabel
@export var hint:String

@export var prehide = false
@export var hide = false

func _ready():
	text.set_text(hint)
	if prehide == true:
		box.visible = false



func _on_area_2d_body_entered(body):
	if  body.is_in_group("player"):
		box.visible = true


func _on_area_2d_body_exited(body):
	if  body.is_in_group("player"):
		if prehide == true:
			box.visible = false
		if hide == true:
			box.visible = false
