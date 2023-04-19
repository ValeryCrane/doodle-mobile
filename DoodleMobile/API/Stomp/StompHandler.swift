import Foundation

protocol StompHandler {
    associatedtype MessageType: Decodable
    var subscriprionTopics: [StompSubscriptionTopic] { get }
    func handleMessage(_ message: MessageType) -> Bool
}
