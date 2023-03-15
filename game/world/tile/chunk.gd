class_name TileChunck3D
extends Node3D

var buffer : PackedInt32Array
@onready var _visualBody = $visualBody

# Called when the node enters the scene tree for the first time.
func _ready():
	for z in range(16):
		for y in range(8):
			for x in range(16):
				var odd = (x+z) % 2
				var pos = Vector3(x,y*2+odd,z)
				var id = z*128+y*16+x
				_visualBody.multimesh.set_instance_transform(id, Transform3D(Basis(), pos))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
