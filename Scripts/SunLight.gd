extends DirectionalLight3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if (event.is_action_released("increase_brightness")):
		light_energy = clampf(light_energy + 0.05, 0.05, 1.0);
	if (event.is_action_released("decrease_brightness")):
		light_energy = clampf(light_energy - 0.05, 0.05, 1.0);
