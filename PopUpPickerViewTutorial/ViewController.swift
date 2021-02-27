import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
	@IBOutlet weak var pickerViewButton: UIButton!

	let screenWidth = UIScreen.main.bounds.width - 10
	let screenHeight = UIScreen.main.bounds.height / 2
	var selectedRow = 0
	//var selectedRowTextColor = 0
	
	var backGroundColours : KeyValuePairs =
		[
			"WHITE" : UIColor.white,
			"GRAY" : UIColor.lightGray,
			"BLUE" : UIColor.blue,
			"YELLOW" : UIColor.yellow,
			"RED" : UIColor.red,
			"GREEN" : UIColor.green
		]
	
	@IBAction func popUpPicker(_ sender: Any)
	{
		let vc = UIViewController()
		vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
		let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))
		pickerView.dataSource = self
		pickerView.delegate = self
		
		pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
		//pickerView.selectRow(selectedRowTextColor, inComponent: 1, animated: false)
		
		vc.view.addSubview(pickerView)
		pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
		pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
		
		let alert = UIAlertController(title: "Select Background Colour", message: "", preferredStyle: .actionSheet)
		
		alert.popoverPresentationController?.sourceView = pickerViewButton
		alert.popoverPresentationController?.sourceRect = pickerViewButton.bounds
		
		alert.setValue(vc, forKey: "contentViewController")
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
		}))
		
		alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
			self.selectedRow = pickerView.selectedRow(inComponent: 0)
			//self.selectedRowTextColor = pickerView.selectedRow(inComponent: 1)
			let selected = Array(self.backGroundColours)[self.selectedRow]
			//let selectedTextColor = Array(self.backGroundColours)[self.selectedRowTextColor]
			let colour = selected.value
			let name = selected.key
			self.view.backgroundColor = colour
			self.pickerViewButton.setTitle(name, for: .normal)
			//self.pickerViewButton.setTitleColor(selectedTextColor.value, for: .normal)
		}))
		
		self.present(alert, animated: true, completion: nil)
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
	{
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
		label.text = Array(backGroundColours)[row].key
		label.sizeToFit()
		return label
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1 //return 2
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		backGroundColours.count
	}
	
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
	{
		return 60
	}

	
}

