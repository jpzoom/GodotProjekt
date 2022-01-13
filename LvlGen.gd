extends RoomClass

var sizeOfWorld = Vector2(4, 4)
var gridSizeX
var gridSizeY
var numberOfRooms = 20

var takenPositions = []

var rooms = []

func MakeRoomArray():
	rooms.append([])
	rooms[0].append(RoomClass)

func Make2DArray(width, height, value):
    var array = []

    for y in range(height):
        array.append([])
        array[y].resize(width)
        for x in range(width):
            array[y][x] = value
    print(array)

func _ready():
	if numberOfRooms >= (sizeOfWorld.x * 2) * (sizeOfWorld.y * 2):
		numberOfRooms = int(round(sizeOfWorld.x * 2) * (sizeOfWorld.y * 2))
	gridSizeX = int(round(sizeOfWorld.x))
	gridSizeY = int(round(sizeOfWorld.y))

func CreateRooms():
	MakeRoomArray()
	rooms = _init(gridSizeX * 2, gridSizeY * 2)
	rooms[gridSizeX][gridSizeY] = _init(Vector2.ZERO, 1)
	

	var checkPosition = Vector2.ZERO
	
	var randCompare = 0.2
	var randCompareStart = 0.2
	var randCompareEnd = 0.01
	
	for i in numberOfRooms:
		var randPercent = 0.0
		randPercent = (float(i) / (float(numberOfRooms) - 1))
		randCompare = lerp(randCompareStart, randCompareEnd, randPercent)
		# checkPosition = NewPosition()
	
	"""
	for (int i =0; i < numberOfRooms -1; i++){
			float randomPerc = ((float) i) / (((float)numberOfRooms - 1));
			randomCompare = Mathf.Lerp(randomCompareStart, randomCompareEnd, randomPerc);
			//grab new position
			checkPos = NewPosition();
			//test new position
	"""

func NewPosition():
	var x = 0
	var y = 0
	var checkPos = Vector2.ZERO
	
	
	"""
	
	do{
			int index = Mathf.RoundToInt(Random.value * (takenPositions.Count - 1)); // pick a random room
			x = (int) takenPositions[index].x;//capture its x, y position
			y = (int) takenPositions[index].y;
			bool UpDown = (Random.value < 0.5f);//randomly pick wether to look on hor or vert axis
			bool positive = (Random.value < 0.5f);//pick whether to be positive or negative on that axis
			if (UpDown){ //find the position bnased on the above bools
				if (positive){
					y += 1;
				}else{
					y -= 1;
				}
			}else{
				if (positive){
					x += 1;
				}else{
					x -= 1;
				}
			}
			checkingPos = new Vector2(x,y);
		}while (takenPositions.Contains(checkingPos) || x >= gridSizeX || x < -gridSizeX || y >= gridSizeY || y < -gridSizeY); //make sure the position is valid
		return checkingPos;
	
	"""
	
func _physics_process(delta):
	Make2DArray(0, 0, 0)