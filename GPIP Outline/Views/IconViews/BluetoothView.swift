//
//  BluetoothView.swift
//  GPIP Outline
//
//  Created by Albert Huynh on 7/14/23.
//

import SwiftUI
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    @Published var connectedPeripheral: CBPeripheral?
    
    override init(){
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func getPeripheralName(peripheralName: String) -> CBPeripheral? {
        return peripherals.first { $0.name == peripheralName }
    }
    
    func pair(with peripheral: CBPeripheral) {
        self.centralManager?.connect(peripheral, options: nil)
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral){
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "unnamed device")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.centralManager?.stopScan()
        self.connectedPeripheral = peripheral
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?){
        print("Failed to connect to peripheral: \(peripheral.name ?? "unnamed device"). Error: \(error?.localizedDescription ?? "Unknown error")")
    }
    
    
}

//This is the view
struct BluetoothView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
    var body: some View {
        List(bluetoothViewModel.peripheralNames, id: \.self) {peripheralName in
            Button(action: {
                if let peripheral = bluetoothViewModel.getPeripheralName(peripheralName: peripheralName){
                    bluetoothViewModel.pair(with: peripheral)
                }
            }) {
                Text(peripheralName)
            }
        }.navigationTitle("Devices")
    }
}

struct BluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView()
    }
}
