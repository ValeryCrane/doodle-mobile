import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol HttpRequest {
    associatedtype Response: Decodable
    
    var query: String { get }
    var method: HttpMethod { get }
    var parameters: Encodable? { get }
    var body: Encodable? { get }
    
    func send(
        success: @escaping (Response) -> Void,
        fail: @escaping (Error?) -> Void
    )
    func send(
        success: @escaping (Response) -> Void,
        fail: @escaping (Error?) -> Void,
        finally: @escaping () -> Void
    )
}

extension HttpRequest {
    func send(
        success: @escaping (Response) -> Void,
        fail: @escaping (Error?) -> Void
    ) {
        send(success: success, fail: fail, finally: {})
    }
    
    func send(
        success: @escaping (Response) -> Void,
        fail: @escaping (Error?) -> Void,
        finally: @escaping () -> Void
    ) {
        let url = createURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = extractBody()
        request.setValue(Global.accessToken, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            defer { finally() }
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("HTTP query failed!")
                fail(error)
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("HTTP query returned bad status!")
                fail(nil)
                return
            }
            
            // TODO: Избавиться от этого хака
            let nonEmptyData = data.count == 0 ? "{}".data(using: .utf8)! : data
            
            if let response = try? JSONDecoder().decode(Response.self, from: nonEmptyData) {
                success(response)
            } else {
                print("Failed parsing HTTP result!")
            }
        }).resume()
    }
    
    private func extractParameters() -> [String: Any]? {
        if
            let parameters = parameters,
            let data = try? JSONEncoder().encode(parameters),
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let dictionary = jsonObject as? [String: Any]
        {
            return dictionary
        } else {
            return nil
        }
    }
    
    private func extractBody() -> Data? {
        if let body = body {
            return (try? JSONEncoder().encode(body))
        } else {
            return nil
        }
    }
    
    private func createURL() -> URL {
        let urlString = "http://\(Global.host)\(query)"
        var urlComponents = URLComponents(string: urlString)!
        if let parameters = extractParameters() {
            urlComponents.queryItems = parameters.map({ key, value in
                URLQueryItem(name: key, value: "\(value)")
            })
        }
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        return urlComponents.url!
    }
}
