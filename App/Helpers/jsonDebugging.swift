
import Foundation

extension Data {
    func toString() -> String {
        String(data: self, encoding: .utf8) ?? "Could not convert Data to String.utf8"
    }
}
