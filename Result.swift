import ObjectMapper

class <#name#> : Response {
	
	var data = [Model1]()
	
	override func mapping(map: Map) {

        super.mapping(map: map)
    
        data <- map["data"]
		
    }
} 

class Model1 : Mappable {
	
	var createTime = ""
	var descs = ""
	var title = ""
	var btnName = ""
	var btnUrl = ""
	var video = ""
	var updateUid = ""
	var id = ""
	var views = 0
	var content = ""
	var updateTime = ""
	var createUid = ""
	var types = 0
	var author = ""
	var pub = 0
	var stat = 0
	var img = ""
	
	
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
    
        createTime <- map["create_time"]
		descs <- map["descs"]
		title <- map["title"]
		btnName <- map["btn_name"]
		btnUrl <- map["btn_url"]
		video <- map["video"]
		updateUid <- map["update_uid"]
		id <- map["id"]
		views <- map["views"]
		content <- map["content"]
		updateTime <- map["update_time"]
		createUid <- map["create_uid"]
		types <- map["types"]
		author <- map["author"]
		pub <- map["pub"]
		stat <- map["stat"]
		img <- map["img"]
		
    }
} 

