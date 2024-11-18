extends Area2D

@onready var scene = get_tree().get_root()
@export var speed = 1000
@export var damage = 2
@export var selfkill:bool = false
@export var decal:PackedScene
@export var explosion:PackedScene
@export var explosive:bool = false
@onready var bulletDecal = load("res://Prefabs/bullet_decal.tscn")
@onready var explosiveDecal = load("res://Prefabs/explosion.tscn")

func _physics_process(delta):
	position += transform.x * speed * delta
	if selfkill == true:
		await get_tree().create_timer(0.2).timeout
		self.queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.hit(damage)
	elif body.is_in_group("player"):
		body.hit(damage)
	if explosive == false:
		if !body.is_in_group("enemy"):
			if !body.is_in_group("player"):
				var i = bulletDecal.instantiate()
				scene.add_child(i)
				i.transform = $Marker2D.global_transform
	elif explosive == true:
		var i = explosiveDecal.instantiate()
		scene.add_child(i)
		i.transform = $".".global_transform
	queue_free()
