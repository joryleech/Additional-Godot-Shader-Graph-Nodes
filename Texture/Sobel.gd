@tool
extends VisualShaderNodeCustom
class_name VisualShaderSobel 


func _get_global_code(mode):
	return "
	const mat3 sobel_x = mat3(
	vec3(-1, 0, 1),
	vec3(-2, 0, 2),
	vec3(-1, 0, 1)
	);
	
	const mat3 sobel_y = mat3(
	vec3(-1, -2, -1),
	vec3(0, 0, 0),
	vec3(1, 2, 1)
	);
	
	vec3 grayscale(vec3 color){
		float grayscale_luminance_weight = 1.0; //reduce this to ignore human perception
		return mix(vec3((color.r + color.g + color.b) / 3.0),  vec3(0.299 * color.r + 0.587 * color.g + 0.114 * color.b), grayscale_luminance_weight);
	}


"
	
func _get_name() -> String:
	return "Sobel"
	
func _get_category() -> String:
	return "Texture"


func _get_code(input_vars, output_vars, mode, type) -> String:
	var sampler = input_vars[0]
	var uv = input_vars[1]
	var sample_distance = input_vars[2]
	return "
		vec2 uv = {uv};
		ivec2 texture_size = textureSize({sampler}, 0);
		vec2 offset = 1.0 / vec2(texture_size) * {sample_distance};
		
		mat3 point_luminance_grid;
		
		for(int i = 0; i < 3; i++) {
			for(int j = 0; j < 3; j++) {
				vec3 sample_around_pixel = texture({sampler}, uv + vec2(float(i-1)*offset.x,float(j-1)*offset.y),0).rgb;
				vec3 grayscale_sample = grayscale(sample_around_pixel);
				point_luminance_grid[i][j] = (sample_around_pixel.r + sample_around_pixel.g + sample_around_pixel.b);
			}
		}
		
		float sobel_x_detection = dot(sobel_x[0], point_luminance_grid[0]) + dot(sobel_x[1], point_luminance_grid[1]) + dot(sobel_x[2], point_luminance_grid[2]); // convolution of the image's and intensity's 'x' values
		float sobel_y_detection = dot(sobel_y[0], point_luminance_grid[0]) + dot(sobel_y[1], point_luminance_grid[1]) + dot(sobel_y[2], point_luminance_grid[2]); // convolution of the image's and intensity's 'y' values
		float g = sqrt(pow(sobel_x_detection, 2.0) + pow(sobel_y_detection, 2.0)); // combine x and y of the sobel and get rid of negative values
			
		{output} = vec3(g);
		
	".format({
		"sampler": sampler,
		"output": output_vars[0],
		"uv": uv,
		"sample_distance": sample_distance
	})
	
func _get_description() -> String:
	return "Returns size of texture in a vector"
	
#Input Properties
func _get_input_port_count() -> int:
	return 3
	
func _get_input_port_default_value(port):
	match(port):
		0: 
			return null
		1:
			return Vector2(0,0)
		2: 
			return 1.0;
		_:
			return null;
	
	
func _get_input_port_type(port):
	match(port):
		0:
			return PORT_TYPE_SAMPLER
		1:
			return PORT_TYPE_VECTOR_2D
		2: 
			return PORT_TYPE_SCALAR
		_:
			return PORT_TYPE_VECTOR_2D


func _get_input_port_name(port: int) -> String: 
	match(port):
		0:
			return "Texture Sampler"
		1:
			return "UV"
		2:
			return "Sample Distance (Line Width)"
		_:
			return "Other"

#Output Properties
func _get_output_port_count() -> int:
	return 1
	
func _get_output_port_name(port: int) -> String:
	return "Color"
	
func _get_output_port_type(port: int) -> PortType:
	return PORT_TYPE_VECTOR_3D

func _get_return_icon_type():
	return PORT_TYPE_VECTOR_3D
	
