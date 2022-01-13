extends OptionButton

func initialize(input_mapper):
	for profile_index in input_mapper.profiles:
		var profile_name = input_mapper.profiles[profile_index].capitalize()
		add_item(profile_name, profile_index)
	self.connect("item_selected", input_mapper, "_on_ProfilesMenu_item_selected")
