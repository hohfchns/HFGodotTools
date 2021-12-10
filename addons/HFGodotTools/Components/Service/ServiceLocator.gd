extends Node
class_name ServiceLocator


# Add to this dict as "ServiceName" : rf_service
var __rfd_services: Dictionary = {}

export(String, DIR) var __null_sercvice_dir


signal service_changed(service_name)
signal new_service(service_name)


func get_service(identity: Node, service_name: String) -> Node:
	if service_name in __rfd_services:
		return __rfd_services[service_name]
	# The above code returns from the function, so no need for extra indentation
	
	var n_service_name: String = "Null%s" % service_name
	var null_service: Resource = load("%s/%s.gd" % [__null_sercvice_dir, n_service_name])
	if null_service:
		printerr("Warning! %s tried to retrieve a non-existant service by the name of %s, returning null service!" \
			 % [identity.name, service_name])
		return null_service.new()
	else:
		for i in range(10):
			printerr("Warning! Null service file for %s could not be found!" % service_name)
		
		return null


func provide_service(service_name: String, rf_service: Node) -> void:
	__rfd_services[service_name] = rf_service
	emit_signal("new_service", service_name)

func provide_service_dict(dict: Dictionary) -> void:
	for i in range(dict.size()):
		provide_service(dict.keys()[i], dict.values()[i])


func remove_service(service_name: String) -> void:
	__rfd_services.erase(service_name)
	emit_signal("service_changed", service_name)


func overwrite_service(service_name: String, rf_new_service: Node) -> void:
	__rfd_services[service_name] = rf_new_service
	emit_signal("service_changed", service_name)


func get_available_services() -> Array:
	return __rfd_services.keys()

