//
//  PublicationDetailsController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 14..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import CoreData
import Cocoa

class PublicationDetailsController: NSViewController {
    
    @IBOutlet weak var notSavedIcon: NSImageView!
    @IBOutlet weak var validationResultsTable: NSTableView!
    @IBOutlet weak var validationResultsTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var deadlinesTable: NSTableView!
    @IBOutlet weak var deadlinesTableHeightConstraint: NSLayoutConstraint!
    
    @IBInspectable @objc dynamic var publication: Publication? {
        didSet {
            self.dbContext = self.publication!.managedObjectContext
        }
    }
    @IBInspectable @objc dynamic var validationResults: [ValidationBindableResult]?
    @objc var isEditable: Bool = false
    
    private var dbContext: NSManagedObjectContext!
        
    // MARK: - Setting/removing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(contextChanged(notification:)), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
        self.validationResultsTable.delegate = self
        self.validationResultsTable.backgroundColor = NSColor.clear
        self.deadlinesTable.delegate = self
        self.deadlinesTable.backgroundColor = NSColor.clear
        self.setTableHeights()
        self.validate()
    }
    
    override func viewWillDisappear() {
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear()
    }
    
    // MARK: - Lock button
    
    @IBAction func lockButtonClicked(_ sender: NSButton) {
        switch sender.state {
        case .on:
            break
        case .off:
            self.confirmContextSave()
        default:
            break
        }
    }
    
    // MARK: - Deadlines +/- button
    
    @IBAction func addDeadline(_ sender: NSButton) {
        let deadline = Deadline(context: self.publication!.managedObjectContext!)
        deadline.date = Date()
        deadline.publication = self.publication
    }
    
    @IBAction func removeDeadline(_ sender: NSButton) {
        let index = self.deadlinesTable.selectedRow
        guard index >= 0 else { return }
        let rowView = self.deadlinesTable.rowView(atRow: index, makeIfNecessary: false)
        let cellView = rowView!.view(atColumn: 0) as! NSTableCellView
        let representedObject = cellView.objectValue as! Deadline
        self.deadlinesTable.removeRows(at: IndexSet(integer: index), withAnimation: NSTableView.AnimationOptions.effectFade)
        self.dbContext.delete(representedObject)
    }
    
    // MARK: - NSOpenPanel
    
    @IBAction func openPanel(_ sender: Any?) {
        guard let window = self.view.window else { return }
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.resolvesAliases = true
        openPanel.beginSheetModal(for: window) { (response) in
            guard let pathControl = sender as? NSPathControl else { return }
            pathControl.url = openPanel.url
            print((sender as! NSView).identifier ?? "Nothing")
            print(response)
        }
    }
    
    // MARK: - Etc..
    
    @objc private func contextChanged(notification: Notification) {
        self.validate()
    }
    
    private func validate() {
        guard let publication = self.publication else { return }
        self.validationResults = publication.validate()?.bindableResults
    }
    
    private func setTableHeights() {
        self.validationResultsTable.sizeToFit()
        self.deadlinesTable.sizeToFit()
        self.validationResultsTableHeightConstraint.constant = self.validationResultsTable.frame.height
        let deadlinesTableHeight = self.deadlinesTable.headerView!.frame.height
            + self.deadlinesTable.intrinsicContentSize.height
        self.deadlinesTableHeightConstraint.constant = deadlinesTableHeight
    }
    
    private func confirmContextSave() {
        guard let window = self.view.window else { return }
        if !self.dbContext.hasChanges { return }
        let alertView = NSAlert()
        alertView.messageText = "A beállítások megváltoztak"
        alertView.informativeText = "A kiadványon végzett beállításaid még nincsenek elmentve! Elmented a változásokat?"
        alertView.addButton(withTitle: "Elmentem")
        alertView.addButton(withTitle: "Nem mentem el")
        alertView.beginSheetModal(for: window) { (response) in
            if response == .alertFirstButtonReturn {
                AppDelegate.dbService.save(self.dbContext)
            }
        }
    }
}

// MARK: - TableView delegate

extension PublicationDetailsController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, didAdd rowView: NSTableRowView, forRow row: Int) {
        self.setTableHeights()
    }
    
    func tableView(_ tableView: NSTableView, didRemove rowView: NSTableRowView, forRow row: Int) {
        self.setTableHeights()
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        guard tableView !== self.validationResultsTable else { return false }
        return self.isEditable
    }
}
