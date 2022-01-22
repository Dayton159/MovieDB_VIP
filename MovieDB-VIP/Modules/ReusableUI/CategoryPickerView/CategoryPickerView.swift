//
//  CategoryPickerView.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//

import UIKit

protocol CategoryPickerDelegate: AnyObject {
  func didSelectCategory(_ category: Category)
}

class CategoryPickerView: UIViewController {
  
  @IBOutlet weak var pickerView: UIPickerView!
  @IBOutlet weak var dismissButton: UIButton!
  @IBOutlet weak var doneButton: UIButton!
  
  weak var delegate: CategoryPickerDelegate?
  private var categoryLists: [Category] = []
  
  var selectedCategory: Category?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configurePickerView()
    self.bindView()
    self.loadData()
    self.loadLastValue()
  }
  
  //MARK: - Helpers
  
  private func configurePickerView() {
    pickerView.dataSource = self
    pickerView.delegate = self
  }
  
  private func loadData() {
    categoryLists.removeAll()
    
    categoryLists = Category.allCases
    
    pickerView.reloadAllComponents()
  }
  
  private func bindView() {
    dismissButton.addTarget(self, action: #selector(actionDismiss(_:)), for: .touchUpInside)
    doneButton.addTarget(self, action: #selector(donePressed(_:)), for: .touchUpInside)
  }
  
  private func loadLastValue() {
    guard let category = selectedCategory else { return }
    self.setLastValue(item: category, inComponent: 0)
  }
  
  private func setLastValue(item: Category, inComponent: Int) {
    guard let position = categoryLists.firstIndex(of: item) else { return }
    self.pickerView.selectRow(position, inComponent: inComponent, animated: true)
  }
  
  @objc func actionDismiss(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func donePressed(_ sender: UIButton) {
    let selectedindex = pickerView.selectedRow(inComponent: 0)
    let value = categoryLists[selectedindex]
    self.delegate?.didSelectCategory(value)
    self.dismiss(animated: true, completion: nil)
  }
}

extension CategoryPickerView: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    self.categoryLists.count
  }
}

extension CategoryPickerView: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 45
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = UILabel()
    label.text = categoryLists[row].rawValue
    label.font = Constants.Font.semibold(16)
    label.textAlignment = .center
    label.textColor = .black
    return label
  }
}
