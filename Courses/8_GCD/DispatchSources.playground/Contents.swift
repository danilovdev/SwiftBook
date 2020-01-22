import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "danilovdev",
                          attributes: .concurrent)

let timer = DispatchSource.makeTimerSource(queue: queue)

timer.schedule(deadline: .now(),
               repeating: .seconds(2),
               leeway: .milliseconds(300))
timer.setEventHandler {
    print("Hello world")
}

timer.setCancelHandler {
    print("Timer is cancelled")
}

timer.resume()
