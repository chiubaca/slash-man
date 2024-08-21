extends CanvasLayer

var score = 0

func _on_score_tree_entered():
	print("_on_score_tree_entered")
	GlobalSignal.hit_enemy.connect(update_score)


func _on_score_tree_exiting():
	print("_on_score_tree_exiting")
	GlobalSignal.hit_enemy.disconnect(update_score)
	

func update_score(points):
	score = score + points
	print("score updated",score)
	$Score.text = "YOUR SCORE IS:" + str(score)
