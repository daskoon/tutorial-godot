extends StaticBody2D

var player_in_range = false
var opened = false
var player = null

func _physics_process(delta: float) -> void:
	deal_with_interaction()

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true
		player = body

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
		player = null

func deal_with_interaction():
	if player_in_range and global.player_current_attack == true and not opened:
		open_chest()

func open_chest():
	opened = true
	$Sprite2D.modulate = Color(0.5, 0.5, 0.5)
	
	if player:
		player.player_health = 100
		print("Player healed by chest!")
	
	# Simulate a little jump animation to show it opened
	var tween = create_tween()
	tween.tween_property($Sprite2D, "position:y", -10.0, 0.1).as_relative()
	tween.tween_property($Sprite2D, "position:y", 10.0, 0.1).as_relative()
	
	print("Chest Opened!")
