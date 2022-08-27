

import Foundation
import UIKit

public struct MultiPartData {
     /// File name of upload file
       var fileName: String!
       /// Data in binary format
       var data: Data!
       /// Param for multipart
       var paramKey: String!
       /// Mime type for uplaod file
       var mimeType: String!
       /// File Key (API Key)
       var fileKey: String?
}
