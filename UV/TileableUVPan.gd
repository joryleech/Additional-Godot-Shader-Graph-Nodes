@tool
extends VisualShaderNodeCustom
class_name VisualShaderTileableUVPan

func _get_name() -> String:
	return "TileableUVPan"
	
func _get_category() -> String:
	return "UV"


func _get_code(input_vars, output_vars, mode, type) -> String:
	var uv = input_vars[0]
	var scale = input_vars[1]
	var offset = input_vars[2]
	

	
	return "
		{output} = mod(({uv} * {scale} + {offset}), vec2(1,1));
	".format({
		"uv": uv,
		"output": output_vars[0],
		"scale": scale,
		"offset": offset
	})
	
func _get_description() -> String:
	return "Pans a UV and Tiles it"
	
#Input Properties
func _get_input_port_count() -> int:
	return 3
	
func _get_input_port_default_value(port):
	match(port):
		0: 
			return Vector2(0,0)
		1:
			return Vector2(1,1)
		_:
			return Vector2(0,0)
	
func _get_input_port_name(port: int) -> String: 
	match(port):
		0:
			return "UV"
		1:
			return "Scale"
		_:
			return "Offset"

func _get_input_port_type(port: int) -> PortType:
	match(port):
		0:
			return PORT_TYPE_VECTOR_2D
		1:
			return PORT_TYPE_VECTOR_2D
		_:
			return PORT_TYPE_VECTOR_2D


#Output Properties
func _get_output_port_count() -> int:
	return 1
	
func _get_output_port_name(port: int) -> String:
	return "UV"
	
func _get_output_port_type(port: int) -> PortType:
	return PORT_TYPE_VECTOR_2D
	
func _get_return_icon_type():
	return PORT_TYPE_VECTOR_3D

	
