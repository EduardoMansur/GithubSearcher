import Foundation

/// Main network client for executing network requests
public struct NetworkClient {
    private let session: URLSession
    private let jsonDecoder: JSONDecoder

    /// Initialize a new NetworkClient
    /// - Parameters:
    ///   - configuration: URLSessionConfiguration (defaults to .default)
    ///   - jsonDecoder: JSONDecoder for response decoding (defaults to JSONDecoder())
    public init(
        configuration: URLSessionConfiguration = .default,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = URLSession(configuration: configuration)
        self.jsonDecoder = jsonDecoder
    }

    /// Execute a network request and decode the response
    /// - Parameter request: The network request to execute
    /// - Returns: The decoded response
    /// - Throws: NetworkError if the request fails
    public func execute<T: NetworkRequest>(_ request: T) async throws -> T.Response {
        let urlRequest = try request.buildURLRequest()

        let (data, response) = try await performRequest(urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
        }

        do {
            return try jsonDecoder.decode(T.Response.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }

    // MARK: - Private Methods

    private func performRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: request)
        } catch let urlError as URLError {
            switch urlError.code {
            case .cancelled:
                throw NetworkError.cancelled
            case .timedOut:
                throw NetworkError.timeout
            default:
                throw NetworkError.networkFailure(urlError)
            }
        } catch {
            throw NetworkError.networkFailure(error)
        }
    }
}
