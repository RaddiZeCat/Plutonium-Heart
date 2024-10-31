extends CharacterBody2D

@onready var legs = $Body
@onready var turret = $Turret
@export var speed = 20
@export var maxHealth = 10
@onready var player:Node2D
@onready var navAgent = $NavigationAgent2D as NavigationAgent2D
@onready var last_position:Vector2
@onready var shotTimer = $Timer2
@export var shotCooldown:float = 1
@export var projectile:PackedScene
var currentHealth
var reactionSpeed
enum TankState{SEARCH,SHOOT}
var tankState = TankState.SEARCH
var walk = true
var shoot = false

func _ready():
	player = get_node("%Mech")
	currentHealth = maxHealth
	var rng = RandomNumberGenerator.new()
	reactionSpeed = rng.randf_range(1.0,3.0)
	$Timer.wait_time = reactionSpeed
	print(reactionSpeed)

func _physics_process(delta: float)-> void:
	var dir = to_local(navAgent.get_next_path_position()).normalized()
	
	match tankState:
		TankState.SEARCH:
			walk = true
			shoot = false
		TankState.SHOOT:
			walk = false
			shoot = true
	
	if walk == true:
		velocity = dir * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	
	if shoot == true:
		if shotTimer.time_left > 0.0:
			pass
		else:
			var p = projectile.instantiate()
			owner.add_child(p)
			p.transform = $Turret/Marker2D.global_transform
			shotTimer.start(shotCooldown)
	
	legs.look_at($".".position + Vector2($".".velocity.x,$".".velocity.y))
	turret.look_at(player.position)
	
	if(velocity != Vector2.ZERO):
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.play("Idle")
	
	
 
func seek() -> void:
	navAgent.target_position = player.global_position

func _on_timer_timeout():
	seek()

func hit(damage):
	currentHealth = currentHealth - damage
	if currentHealth <= 0:
		queue_free()



func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		tankState = TankState.SHOOT


func _on_area_2d_body_exited(body):
	tankState = TankState.SEARCH
