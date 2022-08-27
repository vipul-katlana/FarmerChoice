

import Foundation

enum WorkerResponse<T> {
    case success(T)
    case failure(Error)
}
