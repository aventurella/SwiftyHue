//
//  BridgeConfiguration.swift
//  Pods
//
//  Created by Marcel Dittmann on 22.04.16.
//
//

import Foundation
import Gloss

public struct BridgeConfiguration: BridgeResourceDictGenerator, BridgeResource {
    
    public typealias AssociatedBridgeResourceType = BridgeConfiguration;
    
    public let identifier: String
    
    /**
     Name of the bridge. This is also its uPnP name, so will reflect the actual uPnP name after any conflicts have been resolved.
    */
    public let name: String
    
    /**
     The current wireless frequency channel used by the bridge. It can take values of 11, 15, 20,25 or 0 if undefined (factory new).
     */
    public let zigbeechannel: Int
    
    /**
     The unique bridge id. This is currently generated from the bridge Ethernet mac address.
     */
    public var bridgeid: String {
        
        return identifier
    }
    
    /**
     MAC address of the bridge.
     */
    public let mac: String
    
    /**
     Whether the IP address of the bridge is obtained with DHCP.
     */
    public let dhcp: Bool
    
    /**
     IP address of the bridge.
     */
    public let ipaddress: String
    
    /**
     Network mask of the bridge.
     */
    public let netmask: String
    
    /**
     Gateway IP address of the bridge.
     */
    public let gateway: String
    
    /**
     IP Address of the proxy server being used. A value of “none” indicates no proxy.
     */
    public let proxyaddress: String
    
    /**
     Port of the proxy being used by the bridge. If set to 0 then a proxy is not being used.
     */
    public let proxyport: Int
    
    /**
     Current time stored on the bridge.
     */
    public let UTC: String
    
    /**
     The local time of the bridge.
     */
    public let localtime: NSDate
    
    /**
     Timezone of the bridge as OlsenIDs, like "Europe/Amsterdam" or "none" when not configured.
     */
    public let timezone: String
    
    /**
     This parameter uniquely identifies the hardware model of the bridge (BSB001, BSB002).
     */
    public let modelid: String
    
    /**
     Software version of the bridge.
     */
    public let swversion: String
    
    /**
     The version of the hue API in the format <major>.<minor>.<patch>, for example 1.2.1
    */
    public let apiversion: String
    
    /**
     Contains information related to software updates.
     */
    public let swupdate: SoftwareUpdateStatus
    
    /**
     Indicates whether the link button has been pressed within the last 30 seconds.
     */
    public let linkbutton: Bool
    
    /**
     This indicates whether the bridge is registered to synchronize data with a portal account.
     */
    public let portalservices: Bool
    
    /**
     portalconnection
     */
    public let portalconnection: String
    
    /**
     portalstate
     */
    public let portalstate: PortalState
    
    /**
     Indicates if bridge settings are factory new.
     */
    public let factorynew: Bool
    
    /**
     If a bridge backup file has been restored on this bridge from a bridge with a different bridgeid, it will indicate that bridge id, otherwise it will be null.
     */
    public let replacesbridgeid: String
    
    /**
     backup
     */
    public let backup: Backup
    
    /**
     A list of whitelisted users
     */
    public let whitelist: [String: WhitelistEntry]
    
    public init?(json: JSON) {
        
        let dateFormatter = NSDateFormatter.hueApiDateFormatter
        
        guard let identifier: String = "bridgeid" <~~ json,
            let name: String = "name" <~~ json,
            let zigbeechannel: Int = "zigbeechannel" <~~ json,
            let mac: String = "mac" <~~ json,
            let dhcp: Bool = "dhcp" <~~ json,
            let ipaddress: String = "ipaddress" <~~ json,
            let netmask: String = "netmask" <~~ json,
            let gateway: String = "gateway" <~~ json,
            let proxyaddress: String = "proxyaddress" <~~ json,
            let proxyport: Int = "proxyport" <~~ json,
            let UTC: String = "UTC" <~~ json,
            let localtime: NSDate = Decoder.decodeDate("localtime", dateFormatter:dateFormatter)(json),
            let timezone: String = "timezone" <~~ json,
            let modelid: String = "modelid" <~~ json,
            let swversion: String = "swversion" <~~ json,
            let apiversion: String = "apiversion" <~~ json,
            let swupdate: SoftwareUpdateStatus = "swupdate" <~~ json,
            let linkbutton: Bool = "linkbutton" <~~ json,
            let portalservices: Bool = "portalservices" <~~ json,
            let portalconnection: String = "portalconnection" <~~ json,
            let portalstate: PortalState = "portalstate" <~~ json,
            let factorynew: Bool = "factorynew" <~~ json,
            let replacesbridgeid: String = "replacesbridgeid" <~~ json,
            let backup: Backup = "backup" <~~ json
        
            else { return nil }
        
        self.identifier = identifier
        self.name = name
        self.zigbeechannel = zigbeechannel
        self.mac = mac
        self.dhcp = dhcp
        self.ipaddress = ipaddress
        self.netmask = netmask
        self.gateway = gateway
        self.proxyaddress = proxyaddress
        self.proxyport = proxyport
        self.UTC = UTC
        self.localtime = localtime
        self.timezone = timezone
        self.modelid = modelid
        self.swversion = swversion
        self.apiversion = apiversion
        self.swupdate = swupdate
        self.linkbutton = linkbutton
        self.portalservices = portalservices
        self.portalconnection = portalconnection
        self.portalstate = portalstate
        self.factorynew = factorynew
        self.replacesbridgeid = replacesbridgeid
        self.backup = backup
         
        guard let whitelistJSON = json["whitelist"] as? JSON else { return nil }
        self.whitelist = WhitelistEntry.dictionaryFromResourcesJSON(whitelistJSON)
        
    }
    
    public func toJSON() -> JSON? {
        
        var json = jsonify([
            "id" ~~> self.identifier,
            "name" ~~> self.name,
            "zigbeechannel" ~~> self.zigbeechannel,
            "mac" ~~> self.mac,
            "dhcp" ~~> self.dhcp,
            "ipaddress" ~~> self.ipaddress,
            "netmask" ~~> self.netmask,
            "gateway" ~~> self.gateway,
            "proxyaddress" ~~> self.proxyaddress,
            "proxyport" ~~> self.proxyport,
            "UTC" ~~> self.UTC,
            "timezone" ~~> self.timezone,
            "modelid" ~~> self.modelid,
            "swversion" ~~> self.swversion,
            "apiversion" ~~> self.apiversion,
            "swupdate" ~~> self.swupdate,
            "linkbutton" ~~> self.linkbutton,
            "portalservices" ~~> self.portalservices,
            "portalconnection" ~~> self.portalconnection,
            "portalstate" ~~> self.portalstate,
            "factorynew" ~~> self.factorynew,
            "replacesbridgeid" ~~> self.replacesbridgeid,
            "backup" ~~> self.backup,
            "whitelist" ~~> self.whitelist,
            ])
        
        return json
    }
}