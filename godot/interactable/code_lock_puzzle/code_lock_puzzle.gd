extends Node2D

@export var correct_combination : String = "123"
@export var on_puzzle_solve_group : String = ""

@onready var number_buttons : Array[NumberButton] = [$NumberButton1, $NumberButton2, $NumberButton3]
var current_combination = "AAA"

func _ready() -> void:
	for i in range(len(number_buttons)):
		var button = number_buttons[i]
		button.number_changed.connect(_on_number_changed.bind(i))

func _on_number_changed(new_value: int, number_index: int):
	# print("{0}: {1}".format([number_index, new_value]))
	current_combination[number_index] = str(new_value)
	if current_combination == correct_combination:
		var on_puzzle_solve_node = get_tree().get_first_node_in_group(on_puzzle_solve_group)
		assert(on_puzzle_solve_node)
		on_puzzle_solve_node.on_puzzle_solved()
		for button in number_buttons:
			button.deactivate()
