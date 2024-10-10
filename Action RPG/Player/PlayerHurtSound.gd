extends AudioStreamPlayer

func _ready():
	volume_db = -36
	connect("finished", self, "queue_free")
