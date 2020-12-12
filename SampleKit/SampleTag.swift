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
  public static let all: SampleTag = SampleTag(
    rawValue: SampleTag.textures.rawValue | SampleTag.shading.rawValue,
    label: "All",
    icon: "list.bullet")

  /// The tag that includes samples that operate on textures
  public static let textures: SampleTag = .init(rawValue: 1, label: "Textures", icon: "photo")

  /// The tag that includes shading operations
  public static let shading: SampleTag = .init(rawValue: 2, label: "Shading", icon: "rays")

  /// A list of all the tags
  public static let allTags: [SampleTag] = [
    .all,
    .textures,
    .shading,
  ]

  /// Raw value of a tag
  public let rawValue: Int

  /// Label of the tag
  public let label: String

  /// SF Symbol name of the icon image
  public let icon: String

  public init(rawValue: Int) {
    self.rawValue = rawValue
    self.label = "Unknown"
    self.icon = "list.bullet"
  }

  public init(rawValue: Int, label: String, icon: String) {
    self.rawValue = rawValue
    self.label = label
    self.icon = icon
  }
}
