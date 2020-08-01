//
//  AsyncOperationQueue.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 11/28/19.
//

import Foundation

public class AsyncOperationQueue {
  private var queue: [(@escaping () -> ()) -> ()] = []
  private let buffer: TimeInterval

  public init(buffer: TimeInterval = 0.0) {
    self.buffer = buffer
  }
  
  public func addOperation(_ block: @escaping (@escaping () -> ()) -> ()) {
    queue.append(block)
    dequeue()
  }
  
  private func dequeue() {
    guard self.queue.count > 0 else { return }
    let next = self.queue.removeFirst()
    next() { [weak self] in
      guard let self = self else { return }
      DispatchQueue.main.asyncAfter(deadline: .now() + self.buffer) {
        self.dequeue()
      }
    }
  }
}
