extends Node
class_name HFServiceLocator

# --------------------------------------------------------------------------------------
# This is pretty old code, so no guarentees for updates, beyond this documentation one,
# despite there being obvious improvements to make
# --------------------------------------------------------------------------------------
#
# -------------------------------------------------------------------------------
# This is a class to keep track of and provide comopnents (nodes).
# This class doesn't serve any other purpose, it's mostly just made for practice
# -------------------------------------------------------------------------------
#
# --------------------------- USAGE ---------------------------------------------
# An outside class should only use methods/variables that are
# not marked with underscores (__).
#
# The desired services should be registered by calling provide_service
# or provide_service_dict, and removed by calling
# remove_service or overwrite_service
#
# The __null_service_dir should be set (in-editor) to a directory
# with scripts that have file names identical to the service names used to
# identify them, but with "Null" before the start of the name
#
# An outside class is free to use (currently) all events.
#
# Exported variables are free to change in-editor, but
# should not be changed in code.
#--------------------------------------------------------------------------------
#
#------------------- INTERNAL USAGE -------------------------------
# The __rfd_services dict is meant to be used as following:
# "ServiceName" = rf_service
# where "ServiceName" is a string used to identify the service, and
# rf_service is the desired service (node)
# -----------------------------------------------------------------
var __rfd_services: Dictionary = {}

export(String, DIR) var __null_service_dir

# This is the amount of lines that will be printed if something goes wrong
export(int) var __err_print_lines = 10


signal service_changed(service_name)
signal new_service(service_name)


func get_service(identity: Node, service_name: String) -> Node:
	# Return the service if it is registered
	var served = __rfd_services.get(service_name)
	if served:
		return served
	
	# If it's not registered, create a new null service and return it.
	var n_service_name := "Null%s" % service_name
	var null_service: Resource = load("%s/%s.gd" % [__null_service_dir, n_service_name])
	if null_service:
		printerr("Warning! %s tried to retrieve a non-existant service by the name of %s, returning null service!" \
		% [identity.name, service_name])
		return null_service.new()
	else:
		for i in range(__err_print_lines):
			printerr("Error! Null service file for %s could not be found!" % service_name)
		
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

