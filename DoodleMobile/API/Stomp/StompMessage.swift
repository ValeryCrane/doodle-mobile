import Foundation

struct StompMessage {
    let id: String
    let data: Data
    let subscriprionTopic: StompSubscriptionTopic
}
