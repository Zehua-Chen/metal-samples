//
//  ViewController.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/14/20.
//

import Cocoa
import SampleKit

private enum _Section: Hashable {
  case all
}

class TagsViewController: NSViewController, NSTableViewDelegate {
  fileprivate typealias _DataSource = NSTableViewDiffableDataSource<_Section, SampleTag>
  fileprivate typealias _Snapshot = NSDiffableDataSourceSnapshot<_Section, SampleTag>

  @IBOutlet
  weak var tableView: NSTableView!

  fileprivate weak var _appDelegate: AppDelegate!
  fileprivate var _dataSource: _DataSource!

  override func viewDidLoad() {
    super.viewDidLoad()

    _appDelegate = (NSApplication.shared.delegate as! AppDelegate)

    tableView.delegate = self

    _dataSource = _DataSource(tableView: tableView) { tableView, column, row, tag in
      let view = tableView.makeView(withIdentifier: .tagCellView, owner: nil) as! TagCellView
      view.textField!.stringValue = SampleTag.label(for: tag)
      view.imageView!.image = NSImage(
        systemSymbolName: SampleTag.icon(for: tag), accessibilityDescription: nil)

      return view
    }

    var snapshot = _Snapshot()
    snapshot.appendSections([.all])
    snapshot.appendItems(SampleTag.allTags)

    _dataSource.apply(snapshot, animatingDifferences: false)
  }

  func tableViewSelectionDidChange(_ notification: Notification) {
    if let tag = _dataSource.itemIdentifier(forRow: tableView.selectedRow) {
      _appDelegate.samplesFilter.tag = tag
    }
  }
}
