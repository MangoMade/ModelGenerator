import ObjectMapper

/*
{
    "data": {
        "isVerified": false, 
        "login_time": "2天前", 
        "unread": 0, 
        "head_img": "", 
        "count": 6, 
        "balance": 1426.91, 
          "order": [  
            {
                "price": "100", 
                "money": "1.73",
                "goods_name": "测试商品支付", 
                "duration": "3", 
                "duration_type": "月", 
                "day": 82 
            },
            {
                "price": "100",
                "money": "2.7",
                "goods_name": "测试商品支付",
                "duration": "3",
                "duration_type": "月",
                "day": 74
            }
        ]
    },

}
*/


class <#name#> : Response {
	
	var order = [Model1]()
	var isVerified = 0
	var headImg = ""
	var count = 0
	var unread = 0
	var loginTime = ""
	var balance = 0
	
	override func mapping(map: Map) {

        super.mapping(map: map)

        order <- map["data.order"]
		isVerified <- map["data.isVerified"]
		headImg <- map["data.head_img"]
		count <- map["data.count"]
		unread <- map["data.unread"]
		loginTime <- map["data.login_time"]
		balance <- map["data.balance"]
		
    }
} 

class Model1 : Response {
	
	var price = ""
	var day = 0
	var durationType = ""
	var money = ""
	var duration = ""
	var goodsName = ""
	
	override func mapping(map: Map) {

        super.mapping(map: map)

        price <- map["price"]
		day <- map["day"]
		durationType <- map["duration_type"]
		money <- map["money"]
		duration <- map["duration"]
		goodsName <- map["goods_name"]
		
    }
} 

