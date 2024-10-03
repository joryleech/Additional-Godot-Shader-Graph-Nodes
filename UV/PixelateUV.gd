@tool
extends VisualShaderNodeCustom
class_name VisualShaderPixelateUV

func _get_name() -> String:
	return "PixelateUV"
	
func _get_category() -> String:
	return "UV"


func _get_code(input_vars, output_vars, mode, type) -> String:
	var texture = input_vars[0]
	var uv = input_vars[1]
	var scale = input_vars[2]
	

	
	return "
		//PixelateUV
		ivec2 texture_size = textureSize({texture}, 0);
		float x_resolution = float(texture_size.x/int({scale}));
		float y_resolution = float(texture_size.y/int({scale}));
		
		vec2 new_uv = {uv};
		new_uv.x = floor(new_uv.x * x_resolution)/x_resolution;
		new_uv.y = floor(new_uv.y * y_resolution)/y_resolution;
		{output} = new_uv;
	".format({
		"texture": texture,
		"output": output_vars[0],
		"uv": uv,
		"scale": scale
	})
	
func _get_description() -> String:
	return "Reduces resolution of texture based on UV"
	
#Input Properties
func _get_input_port_count() -> int:
	return 3
	
func _get_input_port_default_value(port):
	match(port):
		0: 
			return Texture2D.new()
		1:
			return Vector2(0,0)
		_:
			return 1
	
func _get_input_port_name(port: int) -> String: 
	match(port):
		0:
			return "Texture"
		1:
			return "UV"
		_:
			return "Scale Factor (1/n)"

func _get_input_port_type(port: int) -> PortType:
	match(port):
		0:
			return PORT_TYPE_SAMPLER
		1:
			return PORT_TYPE_VECTOR_2D
		_:
			return PORT_TYPE_SCALAR


#Output Properties
func _get_output_port_count() -> int:
	return 1
	
func _get_output_port_name(port: int) -> String:
	return "UV"
	
func _get_output_port_type(port: int) -> PortType:
	return PORT_TYPE_VECTOR_2D

func _get_return_icon_type():
	return PORT_TYPE_VECTOR_3D

	
