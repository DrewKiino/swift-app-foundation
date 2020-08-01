//
//  WebTree.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 10/11/19.
//

import Foundation

public struct UndirectedGraph<T: Comparable & Hashable> {
  public class Node<T: Comparable & Hashable>: Comparable {
    public let value: T
    public var sources: Set<T>
    public var targets: Set<T>
    
    public init(value: T, sources: Set<T>, targets: Set<T>) {
      self.value = value
      self.sources = sources
      self.targets = targets
    }
    
    public static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
      return lhs.value == rhs.value
    }
    
    public static func < (lhs: Node<T>, rhs: Node<T>) -> Bool {
      return lhs.value < rhs.value
    }
    
    public static func > (lhs: Node<T>, rhs: Node<T>) -> Bool {
      return lhs.value > rhs.value
    }
  }
  
  public private(set) var nodes: [T: Node<T>] = [:]
  public private(set) var lostNodes: [T: Node<T>] = [:]
  
  private let queue = DispatchQueue(label: UUID().uuidString, attributes: .concurrent)
  
  public init() {
  }
  
  // MARK: - Data Modeling
  
  public mutating func setValue(_ value: T, sources: Set<T>, targets: Set<T>) {
    let node = newOrExistingNodeFromValue(value, sources: sources, targets: targets)
    for source in sources {
      newOrExistingNodeFromValue(source, sources: [], targets: [value])
    }
    for target in targets {
      newOrExistingNodeFromValue(target, sources: [value], targets: [])
    }
    maybeAddToLostNodes(node)
  }

  public mutating func removeValue(_ value: T) -> Node<T>? {
    guard let node = nodeFromValue(value) else { return nil }
    for source in node.sources {
      if let sNode = nodeFromValue(source) {
        queue.async(flags: .barrier) {
          sNode.targets.remove(value)
        }
        maybeAddToLostNodes(sNode)
      }
    }
    for target in node.targets {
      if let tNode = nodeFromValue(target) {
        queue.async(flags: .barrier) {
          tNode.sources.remove(value)
        }
        maybeAddToLostNodes(tNode)
      }
    }
    return node
  }
  
  public func sourcesFromValue(_ value: T) -> Set<T> {
    return nodeFromValue(value)?.sources ?? []
  }
  
  public func targetsFromValue(_ value: T) -> Set<T> {
    return nodeFromValue(value)?.targets ?? []
  }
  
  // MARK: - Utility
  
  private func nodeFromValue(_ value: T) -> Node<T>? {
    queue.sync {
      return nodes[value]
    }
  }
  
  private mutating func maybeAddToLostNodes(_ node: Node<T>) {
    if node.sources.isEmpty && node.targets.isEmpty {
      var this = self
      queue.async(flags: .barrier) {
        this.lostNodes[node.value] = node
      }
    }
  }
  
  @discardableResult
  private mutating func newOrExistingNodeFromValue(_ value: T, sources: Set<T>, targets: Set<T>) -> Node<T> {
    if let node = nodeFromValue(value) {
      node.sources = node.sources.union(sources)
      node.targets = node.targets.union(targets)
      return node
    }
    let node = Node(value: value, sources: sources, targets: targets)
    var this = self
    queue.async(flags: .barrier) {
      this.nodes[value] = node
    }
    return node
  }
}

extension UndirectedGraph: CustomStringConvertible {
  public var description: String {
    var string = "Nodes\n"
    for node in nodes.values.sorted(by: <) {
      string += "\(node)"
    }
    string += "Lost Nodes"
    for node in lostNodes.values.sorted(by: <) {
      string += "\(node)"
    }
    return string
  }
}

extension UndirectedGraph.Node: CustomStringConvertible {
  public var description: String {
    return "value: \(value), sources: \(sources), targets: \(targets)\n"
  }
}
