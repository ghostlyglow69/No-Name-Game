extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		var first_tween = get_tree().create_tween()
		var second_tween = get_tree().create_tween()
		
		body.coins += 1
		
		first_tween.tween_property(self, "modulate:a", 0, 0.3)
		second_tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		second_tween.tween_callback(queue_free)
