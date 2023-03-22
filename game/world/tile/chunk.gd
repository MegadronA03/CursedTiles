@tool
class_name TileChunck3D
extends Node3D

@export var DbgUpdate := false

var palette := PackedInt32Array()
var neighbours := [].resize(7)
const buffdim = Vector3i(8,4,8) #that should be constant
var buffer := PackedInt32Array() #256 size should be constant
var meshdata := []
@onready var _visualBody := $visualBody

func update():
	#TODO: compute shader for partially converting buffer data into mesh
	#compute shader should get 8 chunks, generate most data for this model
	# and add mising pices to other referenced chuncks 
	var cs := self.buffdim.x * self.buffdim.y
	for z in range(self.buffdim.z):
		for y in range(self.buffdim.y):
			for x in range(self.buffdim.x):
				var odd := (x+z) % 2
				var pos := Vector3(x,y*2+odd,z)
				var id := (
					z*cs+
					y*self.buffdim.x+
					x)
				#if (self.buffer[id] == 0):
				#	pass
					#self._visualBody.multimesh.set_instance_custom_data(id, Color(self.buffer[id], 0, 0)) #self.buffer[x][y][z]
					#self._visualBody.multimesh.set_instance_transform(id, Transform3D(Basis(), pos))

# Called when the node enters the scene tree for the first time.
func _ready():
	self.buffer.resize(
		self.buffdim.x*
		self.buffdim.y*
		self.buffdim.z)
	self.meshdata.resize(Mesh.ARRAY_MAX)
	self.meshdata[Mesh.ARRAY_VERTEX] = PackedVector3Array([
		Vector3(0,0,0),
		Vector3(1,0,0),
		Vector3(0,0,1)])
	self.meshdata[Mesh.ARRAY_INDEX] = PackedInt32Array([0,1,2])
	self._visualBody.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, self.meshdata)
	var shmat = ShaderMaterial.new()
	shmat.create_placeholder()
	_visualBody.material_override = shmat
	#self._visualBody.multimesh.mesh.material.
	self.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DbgUpdate:
		update()
		DbgUpdate = false
	pass
