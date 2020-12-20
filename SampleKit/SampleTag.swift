//
//  SampleTag.swift
//  SampleKit
//
//  Created by Zehua Chen on 12/12/20.
//

/// Tag of samples
public struct SampleTag: OptionSet, Hashable {
  public typealias RawValue = Int

  /// The tag that includes all of the other tags
  public static let all: SampleTag = [.textures, .shading]

  /// The tag that includes samples that operate on textures
  public static let textures: SampleTag = .init(rawValue: 1)

  /// The tag that includes shading operations
  public static let shading: SampleTag = .init(rawValue: 2)

  /// A list of all the tags
  public static let allTags: [SampleTag] = [
    .all,
    .textures,
    .shading,
  ]

  public static func label(for tag: SampleTag) -> String {
    func localized(key: String) -> String {
      return NSLocalizedString(
        key, tableName: nil, bundle: Sample._bundle, value: key, comment: key)
    }

    switch tag {
    case .all:
      return localized(key: "tag_all")
    case .shading:
      return localized(key: "tag_shading")
    case .textures:
      return localized(key: "tag_textures")
    default:
      return "?"
    }
  }

  public static func icon(for tag: SampleTag) -> String {
    switch tag {
    case .all:
      return "list.bullet"
    case .shading:
      return "rays"
    case .textures:
      return "photo"
    default:
      return "?"
    }
  }

  /// Raw value of a tag
  public let rawValue: Int

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}
