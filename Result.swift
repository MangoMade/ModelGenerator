import ObjectMapper

class <#name#> : Response {
	
	var banner = [Model5]()
	var unread = 0
	var goods = [Model3]()
	var headlines = [Model2]()
	
	override func mapping(map: Map) {

        super.mapping(map: map)
    
        banner <- map["banner"]
		unread <- map["unread"]
		goods <- map["goods"]
		headlines <- map["headlines"]
		
    }
} 

class Model2 : Mappable {
	
	var cid = ""
	var title = ""
	var status = ""
	var productId = ""
	
	
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
    
        cid <- map["cid"]
		title <- map["title"]
		status <- map["status"]
		productId <- map["product_id"]
		
    }
} 

class Model3 : Mappable {
	
	var product = [Model4]()
	var title = ""
	
	
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
    
        product <- map["product"]
		title <- map["title"]
		
    }
} 

class Model4 : Mappable {
	
	var minPurchaseAmount = ""
	var exptectAnnuRate = 0
	var durationType = ""
	var id = ""
	var duration = ""
	
	
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
    
        minPurchaseAmount <- map["min_purchase_amount"]
		exptectAnnuRate <- map["exptect_annu_rate"]
		durationType <- map["duration_type"]
		id <- map["id"]
		duration <- map["duration"]
		
    }
} 

class Model5 : Mappable {
	
	var durationType = ""
	var exptectAnnuRate = 0
	var duration = 0
	var goodsName = ""
	var minPurchaseAmount = 0
	var id = ""
	var maxInvestTotalAmount = 0
	
	
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
    
        durationType <- map["duration_type"]
		exptectAnnuRate <- map["exptect_annu_rate"]
		duration <- map["duration"]
		goodsName <- map["goods_name"]
		minPurchaseAmount <- map["min_purchase_amount"]
		id <- map["id"]
		maxInvestTotalAmount <- map["max_invest_total_amount"]
		
    }
} 

