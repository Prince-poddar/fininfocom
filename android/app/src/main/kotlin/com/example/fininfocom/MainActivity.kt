package com.example.fininfocom

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.os.Build.VERSION_CODES
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {

    private val PERMISSIONS_REQUEST_CODE = 100
    var blueToothStatus=""




    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        NativeMethodChannel.configureChannel(flutterEngine)



        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "channel").setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            if (call.method == "getBluetoothStatus") {

                 blueToothStatus = getBluetoothStatus()

                result.success(blueToothStatus)

            } else {
                result.notImplemented()
            }
        }

    }

    private fun bluetoothPermissions() {
        if (Build.VERSION.SDK_INT > VERSION_CODES.R) {
            if (!hasPermissions(
                    this, Manifest.permission.BLUETOOTH_CONNECT
                )
            ) {
//                requestPermissionForBluetooth()
            }

        }else{
            requestMultiplePermissionForBluetooth()

        }
    }

    private fun requestMultiplePermissionForBluetooth() {
        requestPermissions(
            arrayOf<String>(
                Manifest.permission.BLUETOOTH_CONNECT,
                Manifest.permission.BLUETOOTH
            ),
            PERMISSIONS_REQUEST_CODE
        )
    }

    @RequiresApi(VERSION_CODES.M)
    private fun requestPermissionForBluetooth() {
        if (!hasPermissions(
                this,
                Manifest.permission.BLUETOOTH_CONNECT
            )
        ) {
            requestPermissions(
                arrayOf<String>(
                    Manifest.permission.BLUETOOTH_CONNECT
                ),
                PERMISSIONS_REQUEST_CODE
            )
        }
    }


    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode==120){

            blueToothStatus="Bluetooth is ONN"

        }
        if (hasPermissions(this, Manifest.permission.BLUETOOTH_CONNECT)) {
            //permission granted
            getBluetoothStatus()
        } else {
            //not granted
            bluetoothPermissions()
        }

    }

    fun hasPermissions(context: Context?, vararg permissions: String?): Boolean {
        if (context != null && permissions != null) {
            for (permission in permissions) {
                if (ActivityCompat.checkSelfPermission(
                        context,
                        permission!!
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    return false
                }
            }
        }
        return true
    }


    private fun getBluetoothStatus(): String {
        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.BLUETOOTH_CONNECT
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            bluetoothPermissions()
        } else {
            val bluetoothManager: BluetoothManager = getSystemService(BluetoothManager::class.java)
            val bluetoothAdapter: BluetoothAdapter? = bluetoothManager.getAdapter()
            if (bluetoothAdapter != null) {
                if (!bluetoothAdapter.isEnabled) {
                    val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                    startActivityForResult(enableBtIntent, 120)
                } else {
                    return "Bluetooth is ONN"
                }
            } else {
                return ""

            }

        }
        return ""

    }


}
