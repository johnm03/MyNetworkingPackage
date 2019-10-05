import Combine
import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}


public struct FetchStuff {
    internal let url: URL
    
    public init?(urlPath: String) {
        guard let url = URL(string: urlPath) else {
            return nil
        }
        self.url = url
    }
    
    public func fetchStuff<T: Decodable>(completionBlock: @escaping (Result<T>) -> Void) {
        let networkService = NetworkService()
        let publisher: AnyPublisher<T, Error> = networkService.dataTaskPublisher(withURL: url)
            
        
        _ = publisher.receive(on: DispatchQueue.main).sink(receiveCompletion:{completion in //2
             switch completion {
                 case .failure(let error):
                    completionBlock(.failure(error))
                 case .finished:
                     break
            }
        }) { model in
            completionBlock(.success(model))
        }
        
    }
}
