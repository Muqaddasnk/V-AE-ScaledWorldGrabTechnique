extends RigidBody3D

func _ready():
	var shape = CollisionShape3D.new()
	var box_shape = BoxShape3D.new()
	box_shape.extents = Vector3(1, 1, 1)  # Adjust size as needed
	shape.shape = box_shape
	add_child(shape)

	mass = 1.0

