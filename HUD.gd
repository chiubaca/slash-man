extends CanvasLayer

var score = 0
var health = 100

func _on_score_tree_entered():
	GlobalSignal.add_points.connect(update_score)
	GlobalSignal.reduce_player_health.connect(update_health)


func _on_score_tree_exiting():
	GlobalSignal.add_points.disconnect(update_score)
	GlobalSignal.reduce_player_health.disconnect(update_health)

	

func update_score(points):
	score = score + points
	print("score updated",score)
	$Score.text = "YOUR SCORE IS:" + str(score)

func update_health(damage):
	health = health - damage
	$Health.text = "Health:" + str(health)
