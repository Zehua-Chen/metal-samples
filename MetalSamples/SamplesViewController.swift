//
//  SamplesViewController.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/14/20.
//

import AppKit
import Combine
import SampleKit

private enum _Section: Hashable {
  case all
}

class SamplesViewController: NSViewController, NSTableViewDelegate {
  fileprivate typealias _DataSource = NSTableViewDiffableDataSource<_Section, Sample>
  fileprivate typealias _Snapshot = NSDiffableDataSourceSnapshot<_Section, Sample>

  @IBOutlet
  weak var tableView: NSTableView!

  fileprivate weak var _appDelegate: AppDelegate!
  fileprivate var _dataSource: _DataSource!
  fileprivate var _cancellables: Set<AnyCancellable> = []

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do view setup here.
    view.widthAnchor.constraint(greaterThanOrEqualToConstant: 280).isActive = true

    _dataSource = _DataSource(tableView: tableView) { tableView, column, row, sample in
      let view = tableView.makeView(withIdentifier: .sampleCellView, owner: nil) as! SampleCellView
      view.textField!.stringValue = sample.name

      return view
    }

    _appDelegate = (NSApplication.shared.delegate as! AppDelegate)
    _appDelegate.samplesFilter.$tag.sink { [unowned self] tag in
      var snapshot = _Snapshot()
      snapshot.appendSections([.all])

      let samples = self._appDelegate.samples
        .filter { tag.contains($0.tag) }

      snapshot.appendItems(samples)

      self._dataSource.apply(snapshot, animatingDifferences: false)
    }
    .store(in: &_cancellables)

    tableView.delegate = self
  }

  func tableViewSelectionDidChange(_ notification: Notification) {
    if tableView.selectedRow < 0 {
      _appDelegate.sample.send(nil)
      return
    }

    if let sample = _dataSource.itemIdentifier(forRow: tableView.selectedRow) {
      _appDelegate.sample.send(sample)
    }
  }
}
