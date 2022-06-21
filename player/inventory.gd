extends Node


class_name Inventory

const max_minerals : int = 50

var mineral_tank : int = 0 setget set_mineral_amount

func set_mineral_amount(value): #checks if the mineral tank is full or will become full. If it does cap it at max_minerals
	if value > max_minerals:
		mineral_tank = max_minerals
	else:
		mineral_tank = value
