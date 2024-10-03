@tool
extends VisualShaderNodeCustom
class_name VisualShaderDither

func _get_name() -> String:
	return "ColorCompression"
	
func _get_category() -> String:
	return "Color"

func _get_global_code(mode):
	return "
vec4 compress_color(vec4 color, int color_count) {
	vec4 new_color;
	float color_count_float = float(color_count);
	new_color.r = (floor(color.r * (color_count_float - 1.0f) + 0.5f))/(color_count_float - 1.0f);
	new_color.g = (floor(color.g * (color_count_float - 1.0f) + 0.5f))/(color_count_float - 1.0f);
	new_color.b = (floor(color.b * (color_count_float - 1.0f) + 0.5f))/(color_count_float - 1.0f);
	return new_color;
}
"
func _get_code(input_vars, output_vars, mode, type) -> String:
	var color = input_vars[0]
	var number_of_colors = input_vars[1]
	return "{output} = compress_color({input_color},{input_color_count});".format({
		"output": output_vars[0],
		"input_color":input_vars[0],
		"input_color_count": input_vars[1]
	})
	
	
func _get_description() -> String:
	return "Compresses Color to defined color pallatte count"
	
#Input Properties
func _get_input_port_count() -> int:
	return 2
	
func _get_input_port_name(port: int) -> String: 
	match(port):
		0:
			return "Color"
		_:
			return "Color Count"

func _get_input_port_type(port: int) -> PortType:
	match(port):
		0:
			return PORT_TYPE_VECTOR_4D
		_:
			return PORT_TYPE_SCALAR_INT


#Output Properties
func _get_output_port_count() -> int:
	return 1
	
func _get_output_port_name(port: int) -> String:
	return "Color"
	
func _get_output_port_type(port: int) -> PortType:
	return PORT_TYPE_VECTOR_4D

func _get_return_icon_type():
	return PORT_TYPE_VECTOR_4D
