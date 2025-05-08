extends Node2D

#this is some very shitty code not gonna lie
#but what can I do? I just started in game design in general

var randMoney := randi_range(1000, 10000)
var wagerScore := 0

@onready var wager = get_node("WagerScore")
@onready var money = get_node("MoniScore")
@onready var AnimHandle = get_node("handle/AnimatedSprite2D")
@onready var AnimKey1 = get_node("keys/slotitem1")
@onready var AnimKey2 = get_node("keys/slotitem2")
@onready var AnimKey3 = get_node("keys/slotitem3")
@onready var winloss = get_node("Winlose")

func _process(delta) -> void:
	money.text = "Money: " + str(randMoney)

func _input(event: InputEvent):
	if event.is_action_pressed("left"):
		if wagerScore > 0: 
			wagerScore -= 500
			wager.text = "Wager: " + str(wagerScore)
		else:
			wagerScore = 0
			wager.text = "Wager: " + str(wagerScore)
	elif event.is_action_pressed("right"):
		if wagerScore >= randMoney:
			wager.text = "Wager: " + str(randMoney)
		else:
			wagerScore += 500
			wager.text = "Wager: " + str(wagerScore)
	elif event.is_action_pressed("bet") and (randMoney > 0 or randMoney > 500) and wagerScore >= 500:
		AnimHandle.play("default")
		minus_money()
		start_spinning()
		cal_winloss()

func cal_winloss():
	print(AnimKey1.frame, " : ", AnimKey2.frame, " : ", AnimKey3.frame)
	if AnimKey1.frame == AnimKey2.frame and AnimKey1.frame == AnimKey3.frame:
		winloss.text = "You Won! Hooray"
		randMoney += wagerScore * 2
		money.text = "Money: " + str(randMoney)
	else:
		winloss.text = "You Lose!"

func start_spinning():
	AnimKey1.frame = randi_range(0, 2)
	AnimKey2.frame = randi_range(0, 2)
	AnimKey3.frame = randi_range(0, 2)


func minus_money():
	randMoney -= wagerScore
	money.text = "Money: " + str(randMoney)		
