import Foundation
import SwiftStomp

extension StompHandler {
    fileprivate func processMessage(_ message: StompMessage) -> Bool {
        guard subscriprionTopics.contains(message.subscriprionTopic) else { return false }
        
        if let messageJson = try? JSONDecoder().decode(MessageType.self, from: message.data) {
            return handleMessage(messageJson)
        } else {
            return false
        }
    }
}


class StompManager {
    static let shared = StompManager()
    
    var connectionStatus: StompConnectionStatus {
        swiftStomp.connectionStatus
    }
    
    private var swiftStomp: SwiftStomp!
    // TODO: Заиспользовать Set
    private var handlers: [any StompHandler] = []
    private var subscriptionTopics: [StompSubscriptionTopic] = []
    
    func start() {
        swiftStomp = SwiftStomp(host: URL(string: "ws://" + Global.host + Global.websocketPath)!)
        swiftStomp.delegate = self
        swiftStomp.autoReconnect = true
        swiftStomp.connect()
    }
    
    func addHandler(_ handler: any StompHandler) {
        handlers.append(handler)
        subscriptionTopics.append(contentsOf: handler.subscriprionTopics)
        if connectionStatus == .fullyConnected {
            for subscriptionTopic in handler.subscriprionTopics {
                swiftStomp.subscribe(to: subscriptionTopic.rawValue, headers: ["Authorization": Global.accessToken])
                swiftStomp.subscribe(to: "/user" + subscriptionTopic.rawValue, headers: ["Authorization": Global.accessToken])
            }
        }
    }
    
    private func processMessage(_ message: StompMessage) {
        for handler in handlers {
            if handler.processMessage(message) {
                return
            }
        }
        
        let messageString = String.init(decoding: message.data, as: UTF8.self)
        debugPrint("StompManager: Recieved unhandled message \(messageString)")
    }
    
    private func convertMessage(_ message: Any?) -> Data? {
        if let message = message as? Data {
            return message
        } else if let utf8Message = (message as? String)?.utf8 {
            return Data(utf8Message)
        } else {
            return nil
        }
    }
    
    private init() { }
}

extension StompManager: SwiftStompDelegate {
    func onConnect(swiftStomp: SwiftStomp, connectType: StompConnectType) {
        if connectType == .toStomp {
            for subscriptionTopic in subscriptionTopics {
                swiftStomp.subscribe(to: subscriptionTopic.rawValue, headers: ["Authorization": Global.accessToken])
                swiftStomp.subscribe(to: "/user" + subscriptionTopic.rawValue, headers: ["Authorization": Global.accessToken])
                print(subscriptionTopic.rawValue)
            }
        }
    }
    
    func onDisconnect(swiftStomp: SwiftStomp, disconnectType: StompDisconnectType) {
        // TODO: Обработать отключение
        debugPrint("StompManager: Stomp connection was interrupted")
    }
    
    func onMessageReceived(swiftStomp: SwiftStomp, message: Any?, messageId: String, destination: String, headers: [String : String]) {
        if let message = convertMessage(message), let topic = StompSubscriptionTopic(rawValue: destination) {
            processMessage(.init(id: messageId, data: message, subscriprionTopic: topic))
        }
    }
    
    func onReceipt(swiftStomp: SwiftStomp, receiptId: String) {
        // TODO: Мы не получаем чеки. Поресерчить
        debugPrint("StompManager: Recieved reciept with id \(receiptId)")
    }
    
    func onError(swiftStomp: SwiftStomp, briefDescription: String, fullDescription: String?, receiptId: String?, type: StompErrorType) {
        // TODO: Пока не получаем ошибки
        if let fullDescription = fullDescription {
            debugPrint("StompManager: Recieved error \(fullDescription)")
        } else {
            debugPrint("StompManager: Recieved error \(briefDescription)")
        }
        
    }
    
    func onSocketEvent(eventName: String, description: String) {
        // TODO: Непонятно какие ивенты. Поресерчить
        debugPrint("StompManager: Recieved event \(eventName): \(description)")
    }
}
