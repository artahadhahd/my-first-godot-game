extends Node

@export var mob_scene: PackedScene
var score

func game_over():
	# remove monsters
	for n in get_children():
		if n is RigidBody2D:
			remove_child(n)
			n.free()

	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	var dir = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	dir += randf_range(-PI/4, PI/4)
	mob.rotation = dir
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(dir)
	
	add_child(mob)
