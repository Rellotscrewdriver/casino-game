extends Node2D

#this is some very shitty code not gonna lie
#but what can I do? I just started in game design in general

var randMoney := randi_range(1000, 10000)
var wagerScore := 0

# Labels
@onready var wager = get_node("WagerScore")
@onready var money = get_node("MoniScore")
@onready var winloss = get_node("Winlose")

#Animations
@onready var AnimHandle = get_node("handle/AnimatedSprite2D")
@onready var AnimKey1 = get_node("keys/slotitem1")
@onready var AnimKey2 = get_node("keys/slotitem2")
@onready var AnimKey3 = get_node("keys/slotitem3")

# Sounds
@onready var leverS = get_node("lever")
@onready var winnerS = get_node("winner")
@onready var wagerS = get_node("wager")



func _process(delta) -> void:
	money.text = "Money: " + str(randMoney)

func _input(event: InputEvent):
	if event.is_action_pressed("left"):
		wagerS.playing = true
		wager_less()
	elif event.is_action_pressed("right"):
		wagerS.playing = true
		wager_more()
	#this condition makes sure that you don't start with 0 or less than 500 wager to bet
	elif event.is_action_pressed("bet") and (randMoney > 0 or randMoney > 500) and wagerScore >= 500:
		AnimHandle.play("default")
		leverS.playing = true
		minus_money()
		start_spinning()
		cal_winloss()

func wager_more():
	if wagerScore >= randMoney:
		wager.text = "Wager: " + str(randMoney)
	else:
		wagerScore += 500
		wager.text = "Wager: " + str(wagerScore)

func wager_less():
	if wagerScore > 0: 
		wagerScore -= 500
		wager.text = "Wager: " + str(wagerScore)
	else:
		wagerScore = 0
		wager.text = "Wager: " + str(wagerScore)

func cal_winloss():
	if OS.is_debug_build():
		print(AnimKey1.frame, " : ", AnimKey2.frame, " : ", AnimKey3.frame)
	if AnimKey1.frame == AnimKey2.frame and AnimKey1.frame == AnimKey3.frame:
		winloss.text = "You Won! Hooray"
		winnerS.playing = true
		randMoney += wagerScore * 2
	else:
		winloss.text = "You Lose!"

func start_spinning():
	AnimKey1.frame = randi_range(0, 2)
	AnimKey2.frame = randi_range(0, 2)
	AnimKey3.frame = randi_range(0, 2)

func minus_money():
	randMoney -= wagerScore
	money.text = "Money: " + str(randMoney)		
