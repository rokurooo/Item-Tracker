extends Node

var SAVE_DIR = DirAccess.open("user://")
const SavePath = "user://save_data/save.items"

var MONTH: String
var DAY: int
var YEAR: int

func get_current_date() -> String:
	var datetime = Time.get_datetime_dict_from_system()
	var months = ["January", "February", "March", "April", "May", "June", 
				  "July", "August", "September", "October", "November", "December"]
	MONTH = months[datetime["month"] - 1]
	DAY = datetime["day"]
	YEAR = datetime["year"]
	return "%s %d , %d" % [MONTH, DAY, YEAR]

func _ready() -> void:
	if not SAVE_DIR.dir_exists("user://save_data"):
		SAVE_DIR.make_dir("user://save_data")

	if not FileAccess.file_exists(SavePath):
		default_write_file()

	get_current_date()

func save_file(Store: String, Item: String, Price: String):
	Store = Store.to_upper()
	Item = Item.to_upper()
	
	var date = get_current_date()
	
	var existing_data = load_file()
	if existing_data == null:
		existing_data = {}

	# Initialize store array if it doesn't exist
	if Store not in existing_data:
		existing_data[Store] = []

	existing_data[Store].append({
		"Item_Name": Item,
		"Item_Price": float(Price),
		"Date": date
	})
	
	var data = existing_data
	var json_string = JSON.stringify(data, "\t")
	var file = FileAccess.open(SavePath, FileAccess.WRITE)
	
	if file:
		file.store_string(json_string)
		print("saved")
		file.close()
		
	else:
		print("Failed to open file: ", FileAccess.get_open_error())

func load_file():
	if not FileAccess.file_exists(SavePath):
		print("file not found")
		return {}

	var file = FileAccess.open(SavePath, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	var data = JSON.parse_string(content)
	if data is Dictionary:
		return data
	return {}

func default_write_file():
	save_file("RAKE","rakehoe","9999")

func remove_item(shopname,itemname):
	var existing_data = load_file()

	for i in existing_data[shopname]:
		if i["Item_Name"] == itemname:
			existing_data[shopname].erase(i)
	if existing_data[shopname].is_empty():
		existing_data.erase(shopname)

	var json_string = JSON.stringify(existing_data,"\t")
	var file = FileAccess.open(SavePath,FileAccess.WRITE)
	
	if file:
		file.store_string(json_string)
		file.close()

	print('"%s" has been removed'%itemname)

func edit_item(shopname,itemname,newprice):
	var oldprice
	var existing_data = load_file()
	for i in existing_data[shopname]:
		if i["Item_Name"] == itemname:
			oldprice = i["Item_Price"]
			i["Item_Price"] = float(newprice)
			i["Date"] = get_current_date()
			break

	var json_string = JSON.stringify(existing_data,"\t")
	var file = FileAccess.open(SavePath,FileAccess.WRITE)
	
	if file:
		file.store_string(json_string)
		file.close()
	print('"%s" price have beed updated from %f to %s' %[itemname,oldprice,newprice])

func to_sentenced_case(text:String) -> String:
	if text.is_empty():
		return text

	var temptext = text.to_lower()

	temptext = temptext[0].to_upper() + temptext.substr(1)

	return temptext

func search_chars(text: String, search: String) -> bool:
	for i in search:
		if i not in text:
			return false
	return true