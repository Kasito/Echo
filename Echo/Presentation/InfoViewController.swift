//
//  InfoViewController.swift
//  Echo
//
//  Created by Kasito on 22.09.2020.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var localePickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: InfoViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load(numberOfItems: 0)
        bindModelToUI()
    }
    
    func load(numberOfItems: Int) {
        viewModel?.locale = Locale.allCases[numberOfItems].rawValue
        viewModel?.getText { error in
            if error != nil {
                DispatchQueue.main.async {
                    self.showAlert(message: error)
                }
            }
        }
    }
    
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {_ in }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func bindModelToUI() {
        viewModel?.updateHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension InfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel?.numberOfComponents ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Locale.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Locale.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        load(numberOfItems: row)
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.reuseIdentifier) as! InfoCell
        viewModel?.setupCell(cell: cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let label = UILabel()
        label.text = viewModel?.headerText
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        header.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -3).isActive = true
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel?.heightForHeader ?? 0
    }
}
