#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

p2 =
(
Fill out the following information.
)
Gui, Destroy
Gui, Add, Text,, %p2%

Gui, Add, Text,, Is the WAN interface static or dynamic?
Gui Add, Radio, gStaticWAN vRadio1, Static
Gui Add, Radio, gDynamicWAN vRadio2, Dynamic

Gui, Add, Text,, Will the firewall be doing DHCP for the LAN?
Gui Add, Radio, gDHCPYes vRadio3, Yes
Gui Add, Radio, gDHCPNo vRadio4, No

Gui, Add, Text, vClientPublicText, What is the client's public IP in CIDR notation?
Gui Add, Edit, vClientPublic
Gui, Add, Text, vClientPrivateText, What is the client's LAN subnet in CIDR notation?
Gui, Add, Edit, vClientPrivate
Gui, Add, Text, vPublicIPText, What is the WAN IP?
Gui Add, Edit, vPublicIP
Gui, Add, Text, vPublicNetMaskText, What is the WAN Subnet Mask?
Gui, Add, Edit, vPublicNetMask
Gui, Add, Text, vPublicGatewayText, What is the WAN Gateway?
Gui, Add, Edit, vPublicGateway
Gui, Add, Text, vPrivateIPText, What is the lan gateway IP?
Gui Add, Edit, vPrivateIP
Gui, Add, Text, vPrivateNetMaskText, What is the lan subnet mask?
Gui Add, Edit, vPrivateNetMask
Gui, Add, Text, vPrivateRangeStartText, Enter the starting IP for the DHCP scope:
Gui Add, Edit, vPrivateRangeStart
Gui, Add, Text, vPrivateRangeEndText, Enter the ending IP for the DHCP scope:
Gui Add, Edit, vPrivateRangeEnd

Gui, Add, Button,, OK
Gui, Add, Button, x+20, Cancel
Gui, Add, Button, x+20, Clear Radio Buttons

gosub StartingPoint
return

StartingPoint:
    GuiControl Hide, PrivateIPText
    GuiControl Hide, PrivateIP
    GuiControl Hide, PrivateNetMaskText
    GuiControl Hide, PrivateNetMask
    GuiControl Hide, ClientPrivateText
    GuiControl Hide, ClientPrivate
    GuiControl Hide, ClientPublicText
    GuiControl Hide, ClientPublic
    GuiControl Hide, PublicIPText
    GuiControl Hide, PublicIP
    GuiControl Hide, PublicNetMaskText
    GuiControl Hide, PublicNetMask
    GuiControl Hide, PublicGatewayText
    GuiControl Hide, PublicGateway
    GuiControl Hide, PrivateRangeStartText
    GuiControl Hide, PrivateRangeStart
    GuiControl Hide, PrivateRangeEndText
    GuiControl Hide, PrivateRangeEnd
    Gui, Show, Autosize
return

StaticWAN:
    GuiControl Show, PrivateIPText
    GuiControl Show, PrivateIP
    GuiControl Show, PrivateNetMaskText
    GuiControl Show, PrivateNetMask
    GuiControl Show, ClientPrivateText
    GuiControl Show, ClientPrivate
    GuiControl Show, ClientPublicText
    GuiControl Show, ClientPublic
    GuiControl Show, PublicIPText
    GuiControl Show, PublicIP
    GuiControl Show, PublicNetMaskText
    GuiControl Show, PublicNetMask
    GuiControl Show, PublicGatewayText
    GuiControl Show, PublicGateway
    Gui, Show, AutoSize
return

DynamicWAN:
    GuiControl Show, PrivateIPText
    GuiControl Show, PrivateIP
    GuiControl Show, PrivateNetMaskText
    GuiControl Show, PrivateNetMask
    GuiControl Show, ClientPrivateText
    GuiControl Show, ClientPrivate
    GuiControl Hide, ClientPublicText
    GuiControl Hide, ClientPublic
    GuiControl Hide, PublicIPText
    GuiControl Hide, PublicIP
    GuiControl Hide, PublicNetMaskText
    GuiControl Hide, PublicNetMask
    GuiControl Hide, PublicGatewayText
    GuiControl Hide, PublicGateway
    Gui, Show, AutoSize
return

gosub DHCPYes

DHCPYes:
    GuiControl Show, PrivateIPText
    GuiControl Show, PrivateIP
    GuiControl Show, PrivateNetMaskText
    GuiControl Show, PrivateNetMask
    GuiControl Show, ClientPrivateText
    GuiControl Show, ClientPrivate
    GuiControl Show, PrivateRangeStartText
    GuiControl Show, PrivateRangeStart
    GuiControl Show, PrivateRangeEndText
    GuiControl Show, PrivateRangeEnd
    Gui, Show, AutoSize
return

DHCPNo:
    GuiControl Show, PrivateIPText
    GuiControl Show, PrivateIP
    GuiControl Show, PrivateNetMaskText
    GuiControl Show, PrivateNetMask
    GuiControl Show, ClientPrivateText
    GuiControl Show, ClientPrivate
    GuiControl Hide, PrivateRangeStartText
    GuiControl Hide, PrivateRangeStart
    GuiControl Hide, PrivateRangeEndText
    GuiControl Hide, PrivateRangeEnd
    Gui, Show, AutoSize
return

ButtonClearRadioButtons:
GuiControl,,Radio1,0
GuiControl,,Radio2,0
GuiControl,,Radio3,0
GuiControl,,Radio4,0
gosub StartingPoint
return
GuiClose:
Gui, Cancel
ExitApp
ButtonCancel:
Gui, Cancel
ExitApp
ButtonOK:
GuiControlGet, Radio1
GuiControlGet, Radio2
GuiControlGet, Radio3
GuiControlGet, Radio4
GuiControlGet, ClientPublic
GuiControlGet, ClientPrivate
GuiControlGet, PublicIP
GuiControlGet, PublicNetMask
GuiControlGet, PublicGateway
GuiControlGet, PrivateIP
GuiControlGet, PrivateNetMask
GuiControlGet, PrivateRangeStart
GuiControlGet, PrivateRangeEnd

script = Oops! Something went wrong. There should be code here. Maybe you forgot to select any radio buttons?

if (Radio1 = 1 and Radio3 = 1) {
    script =
    (
config system admin
edit "vipadmin"
set accprofile "super_admin"
set password `%iWyn@2bX67RY1!
set trusthost1 96.72.150.137/32
set trusthost2 10.1.10.0/24
set trusthost3 %ClientPrivate%
set trusthost4 %ClientPublic%
end

config system global
set admin-sport 4443
end

config system global
set timezone 12
end

config system snmp sysinfo
set status enable
set description prtg
next
end
config system snmp community
edit 1
set name btpublic
config hosts
edit 1
set ip 144.202.28.230 255.255.255.0
next
end
next
end

config firewall address
edit SSLVPN_TUNNEL_ADDR1
set start-ip 10.212.134.100
set end-ip 10.212.134.200
end

config user local
edit vipadmin
set type password
set passwd `%iWyn@2bX67RY1!
end

config user group
edit "VPN Users"
set group-type firewall
set member vipadmin
end

config system interface
edit wan1
set alias Primary
set mode static
set ip %publicip% %publicnetmask%
set allowaccess http https ping snmp fgfm
end

config router static
edit 1
set gateway %publicgateway%
set device wan1
end

config vpn ssl web portal
edit SSL_Portal
set tunnel-mode enable
set split-tunneling enable
set ip-pools SSLVPN_TUNNEL_ADDR1
set save-password enable
set keep-alive enable
set web-mode disable
set forticlient-download disable
end

config vpn ssl settings
set source-interface wan1
set port 10443
set default-portal "SSL_Portal"
config authentication-rule
edit 1
set groups "VPN Users"
set portal "SSL_Portal"
set realm ''
set client-cert disable
set cipher high
set auth any
next
end
end

config firewall policy
edit 2
set name "SSLVPN_Policy"
set srcintf "ssl.root"
set dstintf "lan"
set srcaddr "SSLVPN_TUNNEL_ADDR1"
set dstaddr "lan"
set action accept
set schedule "always"
set service "ALL"
set inspection-mode flow
set nat disable
set ssl-ssh-profile "no-inspection"
set groups "VPN Users"
next
end

config system interface
edit lan
set alias local
set mode static
set ip %privateip% %privatenetmask%
set allowaccess http https ping snmp fgfm ssh
end
config system dhcp server
edit 1
set dns-service default
set default-gateway %privateip%
set netmask %privatenetmask%
set interface lan
config ip-range
edit 1
set start-ip %privaterangestart%
set end-ip %privaterangeend%
next
end
end
    )
} else if (Radio1 = 1 and Radio4 = 1) {
    script =
    (
config system admin
edit "vipadmin"
set accprofile "super_admin"
set password `%iWyn@2bX67RY1!
set trusthost1 96.72.150.137/32
set trusthost2 10.1.10.0/24
set trusthost3 %ClientPrivate%
set trusthost4 %ClientPublic%
end

config system global
set admin-sport 4443
end

config system global
set timezone 12
end

config system snmp sysinfo
set status enable
set description prtg
next
end
config system snmp community
edit 1
set name btpublic
config hosts
edit 1
set ip 144.202.28.230 255.255.255.0
next
end
next
end

config firewall address
edit SSLVPN_TUNNEL_ADDR1
set start-ip 10.212.134.100
set end-ip 10.212.134.200
end

config user local
edit vipadmin
set type password
set passwd `%iWyn@2bX67RY1!
end

config user group
edit "VPN Users"
set group-type firewall
set member vipadmin
end

config system interface
edit wan1
set alias Primary
set mode static
set ip %publicip% %publicnetmask%
set allowaccess http https ping snmp fgfm
end

config router static
edit 1
set gateway %publicgateway%
set device wan1
end

config vpn ssl web portal
edit SSL_Portal
set tunnel-mode enable
set split-tunneling enable
set ip-pools SSLVPN_TUNNEL_ADDR1
set save-password enable
set keep-alive enable
set web-mode disable
set forticlient-download disable
end

config vpn ssl settings
set source-interface wan1
set port 10443
set default-portal "SSL_Portal"
config authentication-rule
edit 1
set groups "VPN Users"
set portal "SSL_Portal"
set realm ''
set client-cert disable
set cipher high
set auth any
next
end
end

config firewall policy
edit 2
set name "SSLVPN_Policy"
set srcintf "ssl.root"
set dstintf "lan"
set srcaddr "SSLVPN_TUNNEL_ADDR1"
set dstaddr "lan"
set action accept
set schedule "always"
set service "ALL"
set inspection-mode flow
set nat disable
set ssl-ssh-profile "no-inspection"
set groups "VPN Users"
next
end

config system interface
edit lan
set alias local
set mode static
set ip %privateip% %privatenetmask%
set allowaccess http https ping snmp fgfm ssh
end
config system dhcp server
edit 1
set status disable
next
end
end    
    )
} else if (Radio2 = 1 and Radio3 = 1) {
    script =
    (
config system admin
edit "vipadmin"
set accprofile "super_admin"
set password `%iWyn@2bX67RY1!
set trusthost1 96.72.150.137/32
set trusthost2 10.1.10.0/24
set trusthost3 %ClientPrivate%
end

config system global
set admin-sport 4443
end

config system global
set timezone 12
end

config system snmp sysinfo
set status enable
set description prtg
next
end
config system snmp community
edit 1
set name btpublic
config hosts
edit 1
set ip 144.202.28.230 255.255.255.0
next
end
next
end

config firewall address
edit SSLVPN_TUNNEL_ADDR1
set start-ip 10.212.134.100
set end-ip 10.212.134.200
end

config user local
edit vipadmin
set type password
set passwd `%iWyn@2bX67RY1!
end

config user group
edit "VPN Users"
set group-type firewall
set member vipadmin
end

config system interface
edit wan1
set alias Primary
set mode dhcp
set allowaccess http https ping snmp fgfm
end

config vpn ssl web portal
edit SSL_Portal
set tunnel-mode enable
set split-tunneling enable
set ip-pools SSLVPN_TUNNEL_ADDR1
set save-password enable
set keep-alive enable
set web-mode disable
set forticlient-download disable
end

config vpn ssl settings
set source-interface wan1
set port 10443
set default-portal "SSL_Portal"
config authentication-rule
edit 1
set groups "VPN Users"
set portal "SSL_Portal"
set realm ''
set client-cert disable
set cipher high
set auth any
next
end
end

config firewall policy
edit 2
set name "SSLVPN_Policy"
set srcintf "ssl.root"
set dstintf "lan"
set srcaddr "SSLVPN_TUNNEL_ADDR1"
set dstaddr "lan"
set action accept
set schedule "always"
set service "ALL"
set inspection-mode flow
set nat disable
set ssl-ssh-profile "no-inspection"
set groups "VPN Users"
next
end

config system interface
edit lan
set alias local
set mode static
set ip %privateip% %privatenetmask%
set allowaccess http https ping snmp fgfm ssh
end
config system dhcp server
edit 1
set dns-service default
set default-gateway %privateip%
set netmask %privatenetmask%
set interface lan
config ip-range
edit 1
set start-ip %privaterangestart%
set end-ip %privaterangeend%
next
end
end    
    )
} else if (Radio2 = 1 and Radio4 = 1) {
    script =
    (
config system admin
edit "vipadmin"
set accprofile "super_admin"
set password `%iWyn@2bX67RY1!
set trusthost1 96.72.150.137/32
set trusthost2 10.1.10.0/24
set trusthost3 %ClientPrivate%
end

config system global
set admin-sport 4443
end

config system global
set timezone 12
end

config system snmp sysinfo
set status enable
set description prtg
next
end
config system snmp community
edit 1
set name btpublic
config hosts
edit 1
set ip 144.202.28.230 255.255.255.0
next
end
next
end

config firewall address
edit SSLVPN_TUNNEL_ADDR1
set start-ip 10.212.134.100
set end-ip 10.212.134.200
end

config user local
edit vipadmin
set type password
set passwd `%iWyn@2bX67RY1!
end

config user group
edit "VPN Users"
set group-type firewall
set member vipadmin
end

config system interface
edit wan1
set alias Primary
set mode dhcp
set allowaccess http https ping snmp fgfm
end

config vpn ssl web portal
edit SSL_Portal
set tunnel-mode enable
set split-tunneling enable
set ip-pools SSLVPN_TUNNEL_ADDR1
set save-password enable
set keep-alive enable
set web-mode disable
set forticlient-download disable
end

config vpn ssl settings
set source-interface wan1
set port 10443
set default-portal "SSL_Portal"
config authentication-rule
edit 1
set groups "VPN Users"
set portal "SSL_Portal"
set realm ''
set client-cert disable
set cipher high
set auth any
next
end
end

config firewall policy
edit 2
set name "SSLVPN_Policy"
set srcintf "ssl.root"
set dstintf "lan"
set srcaddr "SSLVPN_TUNNEL_ADDR1"
set dstaddr "lan"
set action accept
set schedule "always"
set service "ALL"
set inspection-mode flow
set nat disable
set ssl-ssh-profile "no-inspection"
set groups "VPN Users"
next
end

config system interface
edit lan
set alias local
set mode static
set ip %privateip% %privatenetmask%
set allowaccess http https ping snmp fgfm ssh
end
config system dhcp server
edit 1
set status disable
next
end
end    
    )
}
Gui,Hide
FileDelete, %A_ScriptDir%\GeneratedConfig.txt
FileAppend, %script%, %A_ScriptDir%\GeneratedConfig.txt
TrayTip Woohoo!, File created.
Run %COMSPEC% /c explorer.exe /select`, "%A_ScriptDir%\GeneratedConfig.txt"
Sleep 5000
HideTrayTip() {
    TrayTip
}
ExitApp