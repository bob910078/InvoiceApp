# 電子發票 API 的使用


- [電子發票應用API規格](https://www.einvoice.nat.gov.tw/home/DownLoad?fileName=1510206773173_0.pdf)
- [電子發票證明聯一維及二維條碼規格說明](https://www.einvoice.nat.gov.tw/home/DownLoad?fileName=1575448081679_0.pdf)
- [電子發票應用程式介面(API)使用規範](https://www.einvoice.nat.gov.tw/home/DownLoad?fileName=f1343640284478.pdf)


## 查詢中獎號碼
- 輸入欄位：民國年 + 開獎月份  e.g. 10904
- 開獎月份皆為雙數月
- 假如今天是 8/13，那最近開獎的一期是 05-06
- 假如今天是 8/31，那最近開獎的一期是 05-06
- 假如今天是 9/02，那最近開獎的一期是 07-08
- 拿奇數月去打 api 會得到「沒有資料」
- 拿未來的時間去打 api 會得到「沒有資料」

### request URL 
- https://api.einvoice.nat.gov.tw
- /PB2CAPIVAN/invapp/InvApp

### HTTP Header
- HTTP method `POST`
- CONTENT-TYPE `application/x-www-form-urlencoded`

### HTTP Body
- version = 0.2
- action = QryWinningList
- invTerm = 10906
- appID = poqweopqwopeqwiopiqwo

### response JSON
```json
{
    "v": "0.2",
    "code": "200",
    "msg": "執行成功",
    "updateDate": "1090725",
    "invoYm": "10906",

    "superPrizeAmt": "10000000",    // 千萬特獎金額
    "superPrizeNo": "03016191",     // 千萬特獎號碼

    "spcPrizeAmt": "2000000",       // 特獎金額
    "spcPrizeNo": "62474899",       // 特獎號碼
    "spcPrizeNo2": "",
    "spcPrizeNo3": "",
    
    "firstPrizeAmt": "0200000",     // 頭獎金額
    "firstPrizeNo1": "33657726",    // 頭獎號碼
    "firstPrizeNo2": "06142620",
    "firstPrizeNo3": "66429962",
    "firstPrizeNo4": "",
    "firstPrizeNo5": "",
    "firstPrizeNo6": "",
    "firstPrizeNo7": "",
    "firstPrizeNo8": "",
    "firstPrizeNo9": "",
    "firstPrizeNo10": "",
    
    "secondPrizeAmt": "0040000",
    "thirdPrizeAmt": "0010000",
    "fourthPrizeAmt": "0004000",
    "fifthPrizeAmt": "0001000",
    
    "sixthPrizeAmt": "0000200",
    "sixthPrizeNo1": "790",
    "sixthPrizeNo2": "",
    "sixthPrizeNo3": "",
    "sixthPrizeNo4": "",
    "sixthPrizeNo5": "",
    "sixthPrizeNo6": "",

    "timeStamp": {
        "date": 25,
        "hours": 13,
        "seconds": 26,
        "month": 6,
        "timezoneOffset": -480,
        "year": 120,
        "minutes": 5,
        "time": 1595653526000,
        "day": 6
    },
    
}
```


---
---
---

### 紀錄遇到奇怪的事

如果使用 `Alamofire`，可以得到正確的回應資料。
```swift
let parameters: [String:String] = [
    "version": "0.2",
    "action": "QryWinningList",
    "invTerm": "10906",
    "appID": "EINV7202000000000",
]
var comp = URLComponents()
comp.scheme = "https"
comp.host = "api.einvoice.nat.gov.tw"
comp.path = "/PB2CAPIVAN/invapp/InvApp"
let reqURL = comp.url!
AF.request(reqURL, method: .post, parameters: parameters)
    .validate(contentType: ["application/x-www-form-urlencoded"])
    .response { response in
        debugPrint(response)
}
```

但如果是用這種方式，則會看到 { "code":998,"msg":"appID 不符合規定 (停權或尚未申請)" }
```swift
let parameters: [String:String] = [
    "version": "0.2",
    "action": "QryWinningList",
    "invTerm": "10906",
    "appID": "EINV7202000000000",
]
var comp = URLComponents()
comp.scheme = "https"
comp.host = "api.einvoice.nat.gov.tw"
comp.path = "/PB2CAPIVAN/invapp/InvApp"
let reqURL = comp.url!
var req = URLRequest(url: reqURL)
req.httpMethod = "POST"
req.addValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")

// method 1
req.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

// method 2
req.httpBody = try? JSONEncoder().encode(parameters)

URLSession.shared.dataTask(with: req) { (dataOrNil, responseOrNil, errorOrNil) in
    print(String(data: dataOrNil!, encoding: .utf8))
}.resume()
```

### 比對 alamofire 跟我的方式後發現差異是在 http body 的資料長度不一樣！
- data length: 71 bytes (alamofire)
- data length: 89 bytes (JSONEncoder)
- data length: 89 bytes (JSONSerialization)

### 解決辦法
```swift
req.httpBody = parameters.map({ "\($0.key)=\($0.value)" }).joined(separator: "&").data(using: .utf8)
```
- data length: 71 bytes 




