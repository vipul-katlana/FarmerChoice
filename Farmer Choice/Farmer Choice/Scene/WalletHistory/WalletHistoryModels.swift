

import UIKit

enum WalletHistory {
    
    class ViewModel: WSResponseData {
        var walletBal: String?
        var add_money: String?
        var superwalletBal: String?
        var transactionData: [TransactionData]?
        
        enum CodingKeys: String, CodingKey {
            case walletBal
            case add_money
            case transction_data
            case superwalletBal
        }
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            walletBal = try values.decodeIfPresent(String.self, forKey: .walletBal)
            add_money = try values.decodeIfPresent(String.self, forKey: .add_money)
            superwalletBal = try values.decodeIfPresent(String.self, forKey: .superwalletBal)
            transactionData = try values.decodeIfPresent([TransactionData].self, forKey: .transction_data)
        }
        public override func encode(to encoder: Encoder) throws {
            try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(walletBal, forKey: .walletBal)
            try container.encode(add_money, forKey: .add_money)
            try container.encode(transactionData, forKey: .transction_data)
        }
    }
    
    class TransactionData: Codable {
        var OrderID : String?
        var Remark: String?
        var symbol: String?
        var Amount: String?
        var type: String?
        var TransactionDate: String?
        var add_money: String?
        
        enum CodingKeys: String, CodingKey {
            case OrderID
            case Remark
            case symbol
            case Amount
            case type
            case TransactionDate
            case add_money
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            OrderID = try values.decodeIfPresent(String.self, forKey: .OrderID)
            Remark = try values.decodeIfPresent(String.self, forKey: .Remark)
            symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
            Amount = try values.decodeIfPresent(String.self, forKey: .Amount)
            type = try values.decodeIfPresent(String.self, forKey: .type)
            TransactionDate = try values.decodeIfPresent(String.self, forKey: .TransactionDate)
            add_money = try values.decodeIfPresent(String.self, forKey: .add_money)
            
        }
        
    }
}

