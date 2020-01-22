import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class SafeArray<Element> {
    
    private var array = [Element]()
    
    private let queue = DispatchQueue(label: "DispatchBarrier",
                                      attributes: .concurrent)
    
    public func append(element: Element) {
        queue.async(flags: .barrier) { [weak self] in
            self?.array.append(element)
        }
    }
    
    public var elements: [Element] {
        var result = [Element]()
        queue.sync { [weak self] in
            result = self?.array ?? []
        }
        return result
    }
}

var safeArray = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { index in
    safeArray.append(element: index)
}

print("safeArray: \(safeArray.elements)")
