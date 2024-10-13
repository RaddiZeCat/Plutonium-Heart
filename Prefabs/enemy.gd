extends CharacterBody2D

@onready var legs = $Body
@onready var turret = $Turret
@export var speed = 20
@export var player:Node2D
@onready var navAgent = $NavigationAgent2D as NavigationAgent2D


func _ready():
	pass

func _physics_process(delta: float)-> void:
	var last_position:Vector2
	var dir = to_local(navAgent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	legs.look_at($".".position - last_position)
	turret.look_at(player.position)
	print($".".position - last_position) # get this done in last frame

 
func seek() -> void:
	navAgent.target_position = player.global_position

func _on_timer_timeout():
	seek()
