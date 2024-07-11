class_name Spell
extends Resource

# Declare the properties of the spell
@export var name: String = "Unnamed Spell"
@export var description: String = "No description."
@export var range: int = 1
@export var area_of_effect: int = 1  
@export var damage: int = 0
@export var mana_cost: int = 0
@export var effect: String = "None"  

# You can add methods to handle spell behavior if needed
func cast(target_position: Vector2):
	# Placeholder for spell casting logic
	print("Casting", name, "at position", target_position)
	apply_effect(target_position)

func apply_effect(target_position: Vector2):
	# Placeholder for applying the spell's effect
	print("Applying effect:", effect, "at position", target_position)
