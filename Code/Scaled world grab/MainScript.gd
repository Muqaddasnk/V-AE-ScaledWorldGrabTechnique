extends Node3D


@export_group("Interaction Settings")

@export_subgroup("Distance Settings")
@export var grab_distance: float = 10.0

@export_subgroup("Scale Settings")
@export var scale_increment: float = 0.1  # Amount to scale up/down
# variable to hold the collider object to scale up and down
var selected_collider: Node3D = null 

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			if event is InputEventMouseButton and event.button_index  == MOUSE_BUTTON_LEFT:
				# Scale up the selected collider when left mouse button is clicked
				if selected_collider:
					scale_collider(selected_collider, Vector3(scale_increment, scale_increment, scale_increment))
			elif event is InputEventMouseButton and event.button_index  == MOUSE_BUTTON_RIGHT:
				# Scale down the selected collider when right mouse button is clicked
				if selected_collider:
					scale_collider(selected_collider, Vector3(-scale_increment, -scale_increment, -scale_increment))

# process function to check the collision and then scale up & down
func _process(delta):
	var camera = get_viewport().get_camera_3d()
	if not camera:
		print("No camera found!")
		return

	# Get the mouse position in normalized device coordinates
	var mouse_pos = get_viewport().get_mouse_position()

	# Convert mouse position to ray parameters
	var from = camera.project_ray_origin(mouse_pos)
	var direction = camera.project_ray_normal(mouse_pos)
#
#	# Perform a raycast
	var space_state = get_world_3d().direct_space_state
	var params = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = from + direction * grab_distance
	params.collision_mask = 1  # Make sure this matches the layers of your colliders

	var result = space_state.intersect_ray(params)
	# when mouse clicked on the collisionshape3d
	if result.has("collider"):
		selected_collider = result.collider

	else:
		selected_collider = null
# function to scale up and down on mouse event
# left click for scale up and right click for scale down
func scale_collider(collider: Node3D, scale_change: Vector3):
	if collider:
		collider.scale += scale_change





