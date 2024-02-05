extends Resource
class_name ThemeMapData

## The target node
@export
var node_path: NodePath

# TODO Perhaps make this an `@export_enum` ?
## color/stylebox/...
@export
var property_type: StringName

## The property to override on the node
@export
var node_override: StringName

## The desired theme property's name as defined in the theme resource
@export
var theme_property: StringName


