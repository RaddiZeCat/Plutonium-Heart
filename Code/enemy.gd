extends CharacterBody2D

@onready var legs = $Body
@onready var turret = $Turret
@export var speed = 20
@export var maxHealth = 10
@onready var player:Node2D
@onready var navAgent = $NavigationAgent2D as NavigationAgent2D
@onready var last_position:Vector2
var currentHealth
var reactionSpeed

func _ready():
	player = get_node("%Mech")
	currentHealth = maxHealth
	var rng = RandomNumberGenerator.new()
	reactionSpeed = rng.randf_range(1.0,3.0)
	$Timer.wait_time = reactionSpeed
	print(reactionSpeed)

func _physics_process(delta: float)-> void:
	var dir = to_local(navAgent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	
	legs.look_at($".".position + Vector2($".".velocity.x,$".".velocity.y))
	turret.look_at(player.position)
 
func seek() -> void:
	navAgent.target_position = player.global_position

func _on_timer_timeout():
	seek()

func hit(damage):
	currentHealth = currentHealth - damage
	if currentHealth <= 0:
		queue_free()
