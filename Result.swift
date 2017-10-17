import ObjectMapper

class <#name#> : Response {
	
	var apiVersion = ""
	var title = ""
	var createTime = ""
	var relWords = ""
	var image = ""
	var relCid = 0
	var userName = ""
	var music = ""
	var views = ""
	var id = 0
	var loves = 0
	var desc = ""
	var isFaved = 0
	var uid = ""
	var type = 0
	var shareImage = ""
	var isLove = 0
	var shareUrl = ""
	var image = ""
	var nickname = ""
	var id = 0
	
	override func mapping(map: Map) {

        super.mapping(map: map)
    
        apiVersion <- map["api_version"]
		title <- map["data.title"]
		createTime <- map["data.extend.create_time"]
		relWords <- map["data.extend.rel_words"]
		image <- map["data.extend.image"]
		relCid <- map["data.extend.rel_cid"]
		userName <- map["data.extend.user_name"]
		music <- map["data.extend.music"]
		views <- map["data.views"]
		id <- map["data.id"]
		loves <- map["data.loves"]
		desc <- map["data.desc"]
		isFaved <- map["data.is_faved"]
		uid <- map["data.uid"]
		type <- map["data.type"]
		shareImage <- map["data.share_image"]
		isLove <- map["data.is_love"]
		shareUrl <- map["data.share_url"]
		image <- map["data.user.image"]
		nickname <- map["data.user.nickname"]
		id <- map["data.user.id"]
		
    }
} 

