//
// Keychain helper for iOS/Swift.
//
// https://github.com/marketplacer/keychain-swift
//
// This file was automatically generated by combining multiple Swift source files.
//


// ----------------------------
//
// KeychainSwift.swift
//
// ----------------------------

import Security
import Foundation

/**
 A collection of helper functions for saving text and data in the keychain.
 */
public class KeychainSwift {
    
    var lastQueryParameters: [String: NSObject]? // Used by the unit tests
    
    /// Contains result code from the last operation. Value is noErr (0) for a successful result.
    public var lastResultCode: OSStatus = noErr
    
    var keyPrefix = "" // Can be useful in test.
    
    /**
    Specify an access group that will be used to access keychain items. Access groups can be used to share keychain items between applications. When access group value is nil all application access groups are being accessed. Access group name is used by all functions: set, get, delete and clear.
    */
    public var accessGroup: String?
    
    public init() { }
    
    /**
     
     - parameter keyPrefix: a prefix that is added before the key in get/set methods. Note that `clear` method still clears everything from the Keychain.
     */
    public init(keyPrefix: String) {
        self.keyPrefix = keyPrefix
    }
    
    /**
     
     Stores the text value in the keychain item under the given key.
     
     - parameter key: Key under which the text value is stored in the keychain.
     - parameter value: Text string to be written to the keychain.
     - parameter withAccess: Value that indicates when your app needs access to the text in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
     
     - returns: True if the text was successfully written to the keychain.
     */
    public func set(value: String, forKey key: String,
        withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
            
            if let value = value.dataUsingEncoding(NSUTF8StringEncoding) {
                return set(value, forKey: key, withAccess: access)
            }
            
            return false
    }
    
    /**
     
     Stores the data in the keychain item under the given key.
     
     - parameter key: Key under which the data is stored in the keychain.
     - parameter value: Data to be written to the keychain.
     - parameter withAccess: Value that indicates when your app needs access to the text in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
     
     - returns: True if the text was successfully written to the keychain.
     
     */
    public func set(value: NSData, forKey key: String,
        withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
            
            delete(key) // Delete any existing key before saving it
            
            let accessible = access?.value ?? KeychainSwiftAccessOptions.defaultOption.value
            
            let prefixedKey = keyWithPrefix(key)
            
            var query = [
                KeychainSwiftConstants.klass       : KeychainSwiftConstants.classGenericPassword,
                KeychainSwiftConstants.attrAccount : prefixedKey,
                KeychainSwiftConstants.valueData   : value,
                KeychainSwiftConstants.accessible  : accessible
            ]
            
            query = addAccessGroupWhenPresent(query)
            lastQueryParameters = query
            
            lastResultCode = SecItemAdd(query as CFDictionaryRef, nil)
            
            return lastResultCode == noErr
    }
    
    /**
     
     Retrieves the text value from the keychain that corresponds to the given key.
     
     - parameter key: The key that is used to read the keychain item.
     - returns: The text value from the keychain. Returns nil if unable to read the item.
     
     */
    public func get(key: String) -> String? {
        if let data = getData(key) {
            if let currentString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
                return currentString
            }
            
            lastResultCode = -67853 // errSecInvalidEncoding
        }
        
        return nil
    }
    
    /**
     
     Retrieves the data from the keychain that corresponds to the given key.
     
     - parameter key: The key that is used to read the keychain item.
     - returns: The text value from the keychain. Returns nil if unable to read the item.
     
     */
    public func getData(key: String) -> NSData? {
        let prefixedKey = keyWithPrefix(key)
        
        var query: [String: NSObject] = [
            KeychainSwiftConstants.klass       : kSecClassGenericPassword,
            KeychainSwiftConstants.attrAccount : prefixedKey,
            KeychainSwiftConstants.returnData  : kCFBooleanTrue,
            KeychainSwiftConstants.matchLimit  : kSecMatchLimitOne ]
        
        query = addAccessGroupWhenPresent(query)
        lastQueryParameters = query
        
        var result: AnyObject?
        
        lastResultCode = withUnsafeMutablePointer(&result) {
            SecItemCopyMatching(query, UnsafeMutablePointer($0))
        }
        
        if lastResultCode == noErr { return result as? NSData }
        
        return nil
    }
    
    /**
     
     Deletes the single keychain item specified by the key.
     
     - parameter key: The key that is used to delete the keychain item.
     - returns: True if the item was successfully deleted.
     
     */
    public func delete(key: String) -> Bool {
        let prefixedKey = keyWithPrefix(key)
        
        var query: [String: NSObject] = [
            KeychainSwiftConstants.klass       : kSecClassGenericPassword,
            KeychainSwiftConstants.attrAccount : prefixedKey ]
        
        query = addAccessGroupWhenPresent(query)
        lastQueryParameters = query
        
        lastResultCode = SecItemDelete(query as CFDictionaryRef)
        
        return lastResultCode == noErr
    }
    
    /**
     
     Deletes all Keychain items used by the app. Note that this method deletes all items regardless of the prefix settings used for initializing the class.
     
     - returns: True if the keychain items were successfully deleted.
     
     */
    public func clear() -> Bool {
        var query: [String: NSObject] = [ kSecClass as String : kSecClassGenericPassword ]
        query = addAccessGroupWhenPresent(query)
        lastQueryParameters = query
        
        lastResultCode = SecItemDelete(query as CFDictionaryRef)
        
        return lastResultCode == noErr
    }
    
    /// Returns the key with currently set prefix.
    func keyWithPrefix(key: String) -> String {
        return "\(keyPrefix)\(key)"
    }
    
    func addAccessGroupWhenPresent(items: [String: NSObject]) -> [String: NSObject] {
        guard let accessGroup = accessGroup else { return items }
        
        var result: [String: NSObject] = items
        result[KeychainSwiftConstants.accessGroup] = accessGroup
        return result
    }
}


// ----------------------------
//
// KeychainSwiftAccessOptions.swift
//
// ----------------------------

import Security

/**
 These options are used to determine when a keychain item should be readable. The default value is AccessibleWhenUnlocked.
 */
public enum KeychainSwiftAccessOptions {
    
    /**
     
     The data in the keychain item can be accessed only while the device is unlocked by the user.
     
     This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute migrate to a new device when using encrypted backups.
     
     This is the default value for keychain items added without explicitly setting an accessibility constant.
     
     */
    case AccessibleWhenUnlocked
    
    /**
     
     The data in the keychain item can be accessed only while the device is unlocked by the user.
     
     This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
     
     */
    case AccessibleWhenUnlockedThisDeviceOnly
    
    /**
     
     The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
     
     After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute migrate to a new device when using encrypted backups.
     
     */
    case AccessibleAfterFirstUnlock
    
    /**
     
     The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
     
     After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
     
     */
    case AccessibleAfterFirstUnlockThisDeviceOnly
    
    /**
     
     The data in the keychain item can always be accessed regardless of whether the device is locked.
     
     This is not recommended for application use. Items with this attribute migrate to a new device when using encrypted backups.
     
     */
    case AccessibleAlways
    
    /**
     
     The data in the keychain can only be accessed when the device is unlocked. Only available if a passcode is set on the device.
     
     This is recommended for items that only need to be accessible while the application is in the foreground. Items with this attribute never migrate to a new device. After a backup is restored to a new device, these items are missing. No items can be stored in this class on devices without a passcode. Disabling the device passcode causes all items in this class to be deleted.
     
     */
    case AccessibleWhenPasscodeSetThisDeviceOnly
    
    /**
     
     The data in the keychain item can always be accessed regardless of whether the device is locked.
     
     This is not recommended for application use. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
     
     */
    case AccessibleAlwaysThisDeviceOnly
    
    static var defaultOption: KeychainSwiftAccessOptions {
        return .AccessibleWhenUnlocked
    }
    
    var value: String {
        switch self {
        case .AccessibleWhenUnlocked:
            return toString(kSecAttrAccessibleWhenUnlocked)
            
        case .AccessibleWhenUnlockedThisDeviceOnly:
            return toString(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
            
        case .AccessibleAfterFirstUnlock:
            return toString(kSecAttrAccessibleAfterFirstUnlock)
            
        case .AccessibleAfterFirstUnlockThisDeviceOnly:
            return toString(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
            
        case .AccessibleAlways:
            return toString(kSecAttrAccessibleAlways)
            
        case .AccessibleWhenPasscodeSetThisDeviceOnly:
            return toString(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
            
        case .AccessibleAlwaysThisDeviceOnly:
            return toString(kSecAttrAccessibleAlwaysThisDeviceOnly)
        }
    }
    
    func toString(value: CFStringRef) -> String {
        return KeychainSwiftConstants.toString(value)
    }
}


// ----------------------------
//
// TegKeychainConstants.swift
//
// ----------------------------

import Foundation
import Security

public struct KeychainSwiftConstants {
    public static var klass: String { return toString(kSecClass) }
    public static var classGenericPassword: String { return toString(kSecClassGenericPassword) }
    public static var attrAccount: String { return toString(kSecAttrAccount) }
    public static var valueData: String { return toString(kSecValueData) }
    public static var returnData: String { return toString(kSecReturnData) }
    public static var matchLimit: String { return toString(kSecMatchLimit) }
    public static var accessGroup: String { return toString(kSecAttrAccessGroup) }
    
    /**
     
     A value that indicates when your app needs access to the data in a keychain item. The default value is AccessibleWhenUnlocked. For a list of possible values, see KeychainSwiftAccessOptions.
     
     */
    public static var accessible: String { return toString(kSecAttrAccessible) }
    
    static func toString(value: CFStringRef) -> String {
        return value as String
    }
}
