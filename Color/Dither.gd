@tool
extends VisualShaderNodeCustom
class_name VisualShaderColorCompression

func _get_name() -> String:
	return "Dither"
	
func _get_category() -> String:
	return "Color"

func _get_global_code(mode):
	return "
	const int bayer2[] = {
		0, 2,
		3, 1
	};

	const int bayer4[] = {
		0, 8, 2, 10,
		12, 4, 14, 6,
		3, 11, 1, 9,
		15, 7, 13, 5
	};

	const int bayer8[] = {
		0, 32, 8, 40, 2, 34, 10, 42,
		48, 16, 56, 24, 50, 18, 58, 26,  
		12, 44,  4, 36, 14, 46,  6, 38, 
		60, 28, 52, 20, 62, 30, 54, 22,  
		3, 35, 11, 43,  1, 33,  9, 41,  
		51, 19, 59, 27, 49, 17, 57, 25, 
		15, 47,  7, 39, 13, 45,  5, 37, 
		63, 31, 55, 23, 61, 29, 53, 21
	};
	
	float getBayer2(int x, int y) {
		return float(bayer2[(x % 2) + (y % 2) * 2]) * (1.0f / 4.0f) - 0.5f;
	}

	float getBayer4(int x, int y) {
		return float(bayer4[(x % 4) + (y % 4) * 4]) * (1.0f / 16.0f) - 0.5f;
	}

	float getBayer8(int x, int y) {
		return float(bayer8[(x % 8) + (y % 8) * 8]) * (1.0f / 64.0f) - 0.5f;
	}

"
	
func _get_code(input_vars, output_vars, mode, type) -> String:
	var color = input_vars[0]
	var uv = input_vars[1]
	var resolution = input_vars[2]
	var bayerLevel = input_vars[3]
	var spread = input_vars[4]
	return "
	vec2 uv = {uv};
	float bayerValues[3] = {0.0,0.0,0.0};
	vec2 resolution = {resolution};
	int x = int(uv.x * resolution.x); //Please pixelate with pixelation node
	int y = int(uv.y * resolution.y);
	int bayerLevel = {bayerLevel};
	
	//GPU Hates branches, do it all its faster probably.
	bayerValues[0] = getBayer2(x,y);
	bayerValues[1] = getBayer4(x,y);
	bayerValues[2] = getBayer8(x,y);
	
	vec3 output = {color} + ({spread} * bayerValues[bayerLevel]);
	
	{output} = output;
	
".format({
	"uv":uv,
	"color":color,
	"bayerLevel": bayerLevel,
	"output":output_vars[0],
	"spread": spread,
	"resolution": resolution
})

func _get_input_port_default_value(port):
	match(port):
		0: 
			return Texture2D.new()
		1:
			return Vector2(0,0)
		2:
			return Vector2(0,0)
		3:
			return 1
		4: 
			return 1.0
	
func _get_description() -> String:
	return "Compresses Color to defined color pallatte count"
	
#Input Properties
func _get_input_port_count() -> int:
	return 5
	
func _get_input_port_name(port: int) -> String: 
	match(port):
		0:
			return "Texture"
		1:
			return "UV"
		2:
			return "Resolution of Texture"
		3:
			return "Bayer Level (0,1,2)"
		_:
			return "Spread"

func _get_input_port_type(port: int) -> PortType:
	match(port):
		0:
			return PORT_TYPE_VECTOR_3D
		1:
			return PORT_TYPE_VECTOR_2D
		2:
			return PORT_TYPE_VECTOR_2D
		3:
			return PORT_TYPE_SCALAR_INT
		_:
			return PORT_TYPE_SCALAR


#Output Properties
func _get_output_port_count() -> int:
	return 1
	
func _get_output_port_name(port: int) -> String:
	return "Texture"
	
func _get_output_port_type(port: int) -> PortType:
	return PORT_TYPE_VECTOR_3D

func _get_return_icon_type():
	return PORT_TYPE_VECTOR_3D
