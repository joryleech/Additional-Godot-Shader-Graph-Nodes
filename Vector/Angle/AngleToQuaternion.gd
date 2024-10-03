@tool
extends VisualShaderNodeCustom
class_name VisualShaderAngleToQuaternion

func _get_name() -> String:
	return "AngleToQuaternion"
	
func _get_category() -> String:
	return "Vector/Angle"

func _get_global_code(mode: Shader.Mode):
	return "
vec4 convert_angle_to_quaternion(vec3 angle){

	// Calculate the half angles
	vec3 halfAngle = angle * 0.5;

	// Calculate sin and cos of half angles
	float c1 = cos(halfAngle.x);
	float s1 = sin(halfAngle.x);
	float c2 = cos(halfAngle.y);
	float s2 = sin(halfAngle.y);
	float c3 = cos(halfAngle.z);
	float s3 = sin(halfAngle.z);

	// Create the quaternion
	vec4 quaternion;
	quaternion.x = s1 * c2 * c3 + c1 * s2 * s3;
	quaternion.y = c1 * s2 * c3 - s1 * c2 * s3;
	quaternion.z = c1 * c2 * s3 + s1 * s2 * c3;
	quaternion.w = c1 * c2 * c3 - s1 * s2 * s3;
	
	return quaternion;
}"
	
func _get_code(input_vars, output_vars, mode, type) -> String:
	var input_angle : String = input_vars[0]
	var angle_type: int = get_option_index(0)
	var input_angle_formatted = input_angle
	if(angle_type == 0):
		input_angle_formatted = "radians({angle})".format({
			"angle": input_angle
		})

	var code = "{output_var} = convert_angle_to_quaternion({angle});"
	return code.format({
		"angle": input_angle_formatted,
		"output_var": output_vars[0]
	})
	
	
func _get_description() -> String:
	return "Converts angle (Radians) Vector3 (XYZ) to Quaternion Vector4"
	
#Input Properties
func _get_input_port_count() -> int:
	return 1
	
func _get_input_port_name(port: int) -> String: 
	return "Angle"

func _get_input_port_type(port: int) -> PortType:
	return PORT_TYPE_VECTOR_3D


#Output Properties
func _get_output_port_count() -> int:
	return 1
	
func _get_output_port_name(port: int) -> String:
	return "Quaternion"
	
func _get_output_port_type(port: int) -> PortType:
	return PORT_TYPE_VECTOR_4D

#Properties Properties
func _get_property_count() -> int:
	return 1

func _get_property_name(port: int):
	return "Angle type"
	
func _get_property_options(index: int) -> PackedStringArray:
	return ["Degrees", "Radians"]
	
func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D
	
