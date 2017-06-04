import Foundation
import Firebase


class User
{
    var username: String
    var company: String
    var memberEmail: String
    var deviceId: String
    var deviceType = "主機"
    var description: String
    
    var dictionary: [String: String]
    {
        return ["username": self.username,"company": self.company,"memberEmail": self.memberEmail,
                "deviceId": self.deviceId,"deviceType": self.deviceType, "description":self.description]
    }
    
    init(username: String, company: String, memberEmail:String, deviceId:String, description:String)
    {
        self.username = username; self.company = company; self.memberEmail = memberEmail
        self.deviceId = deviceId; self.description = description;
    }
    
    /*init?(snapshot: FIRDataSnapshot)
    {
        guard let dict = snapshot.value as? [String: String] else { return nil }
        guard let name = dict["username"] else { return nil }
        guard let company  = dict["company"]  else { return nil }
        guard let text = dict["deviceType"] else { return nil }
        
        self.username = name
        self.company = company
        self.deviceType = text
    }*/
}
