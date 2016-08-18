//
//  ViewController.swift
//  BluetoothConnec
//
//  Created by IndiaTeam on 11/08/16.
//  Copyright © 2016 IndiaTeam. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController ,CBCentralManagerDelegate ,CBPeripheralDelegate {
    
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var writcharacteristics: CBCharacteristic!
    var service: CBService!
    var characteristics: CBCharacteristic!
    
    var  bluetoothAvailable = false
    let message = "1"

    @IBOutlet var deviceName: UILabel!
    @IBOutlet var serviceName: UILabel!
    @IBOutlet var charactersiticsName: UILabel!
    
    func centralManagerDidUpdateState(central: CBCentralManager)
    {
        
        print("checkingStaus")
        switch (central.state)
        {
        case .PoweredOff:
            print(" BLE is poweredoff")
        case .PoweredOn:
            print("BLE is poweredon")
        case .Resetting:
            print("BLE is Resetting")
        case .Unauthorized:
            print("BLE state is unauthorized")
        case .Unknown:
            print("BLE state is unknown")
        case .Unsupported:
            print("BLE state is unsupported to this platform")
        }
        if bluetoothAvailable == true {
            discoverDevices()
        }
    }
   
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
       
        //Stop scaning
        self.centralManager.stopScan()
        print("Stopped scanning proccess")
        //Set as the peripheral to use and established connection
        //self.peripheral = peripheral
        //self.peripheral.delegate = self
        //self.centralManager.connectPeripheral(peripheral, options: nil)
        peripheral.discoverServices([CBUUID(string: "FFF0")])
        print("connected!!!")
        print(peripheral.name)
        deviceName.text = peripheral.name
    }
    
    func discoverDevices(){
        print("Discovering Devices")
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
        
    }
    
    @IBAction func disconnectDevices(sender: AnyObject) {
        func centralManager(central: CBCentralManager,
                            didDisconnectPeripheral peripheral: CBPeripheral,
                                                    error: NSError?)
        {
            print("CONNECTION WAS DISCONNECTED")
            deviceName.text = "Disconnected"
        }
    }

    
    @IBAction func scan(sender: AnyObject) {
        print("SCAN")
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    @IBAction func send(sender: AnyObject) {
        let data = message.dataUsingEncoding(NSUTF8StringEncoding)
        if writcharacteristics != nil
        {
            print("SENT")
            peripheral!.writeValue(data!, forCharacteristic: writcharacteristics, type: CBCharacteristicWriteType.WithoutResponse)
        }
        else
        {
            print("couldn't send")
        }
    }

    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

