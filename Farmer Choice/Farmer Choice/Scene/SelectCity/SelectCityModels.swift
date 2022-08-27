

import UIKit

struct SubmitForm: Codable {
    let message : String?
    let msgcode: String?
}

struct AvailableCity: Codable {
    let message: String?
    let msgcode: String?
    let User_data: UserData?
}


struct UserData: Codable {
    let city_list : [CityList]?
}

struct CityList : Codable {
    let cityID : String?
    let icon: String?
    let name: String?
    let state: String?
    let areaID: String?
}


enum SelectCity
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
    }
    struct Response
    {
    }
    struct ViewModel
    {
    }
  }
}
