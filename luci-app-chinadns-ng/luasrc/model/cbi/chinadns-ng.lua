-- Licensed to the public under the GNU General Public License v3.

m = Map("chinadns-ng", translate("ChinaDNS-NG"))
m:section(SimpleSection).template  = "chinadns-ng/chinadns-ng_status"

s = m:section(TypedSection, "chinadns", translate("General Setting"))
s.anonymous   = true

o = s:option(Flag, "enable", translate("Enable"))
o.rmempty     = false

o = s:option(Value, "addr", translate("Local Addr"), translate("The listening address can be set to IPV4 or IPV6"))
o.datatype    = "ipaddr"
o.placeholder = "0.0.0.0"
o.default     = "0.0.0.0"
o.rmempty     = false

o = s:option(Value, "port", translate("Local Port"))
o.datatype    = "port"
o.placeholder = 65353
o.default     = 65353
o.rmempty     = false

---- Redirect
o = s:option(ListValue, "redirect", translate("Redirect"), translate("ChinaDNS redirect mode"))
o:value("none", translate("none"))
o:value("dnsmasq-upstream", translate("Run as dnsmasq upstream server"))
o:value("redirect", translate("Redirect 53 port to ChinaDNS"))
o.placeholder = "none"
o.default     = "none"
o.rempty      = false

o = s:option(Value, "execpara", translate("Extra parameters"), translate("Parameters other than address and port"))
-- o.optional    = true
o.datatype    = "string"
o.rmempty     = true

o = s:option(Flag, "s_enable", translate("S_Enable"))
o.rmempty     = true

o = s:option(Value, "s_addr", translate("Local Addr"), translate("The listening address can be set to IPV4 or IPV6"))
o.datatype    = "ipaddr"
o.placeholder = "0.0.0.0"
o.default     = "0.0.0.0"
o.rmempty     = true
o:depends("s_enable", 1)

o = s:option(Value, "s_port", translate("Local Port"))
o.datatype    = "port"
o.placeholder = 63535
o.default     = 63535
o.rmempty     = true
o:depends("s_enable", 1)

---- Redirect
o = s:option(ListValue, "s_redirect", translate("Redirect"), translate("ChinaDNS redirect mode"))
o:value("none", translate("none"))
o:value("dnsmasq-upstream", translate("Run as dnsmasq upstream server"))
o:value("redirect", translate("Redirect 53 port to ChinaDNS"))
o.placeholder = "none"
o.default     = "none"
o.rmempty     = true
o:depends("s_enable", 1)

o = s:option(Value, "s_execpara", translate("Extra parameters"), translate("Parameters other than address and port"))
-- o.optional    = true
o.datatype    = "string"
o.rmempty     = true
o:depends("s_enable", 1)


o = s:option(Button, "update_chnlist", translate("PATH"), translate("The update time may be 1-2 minutes, and it may fail."))
o.template		= "cbi/chinadns_button"
o.inputstyle	= "save"
o.placeholder	= "/etc/chinadns-ng/chnlist.txt"
o.default		= "/etc/chinadns-ng/chnlist.txt"
o.inputtitle	= translate("update")

o = s:option(Button, "gfwlist2dnsmasq", translate("PATH"), translate("The update time may be 1-2 minutes, and it may fail."))
o.template		= "cbi/chinadns_button"
o.inputstyle	= "save"
o.placeholder	= "/etc/chinadns-ng/gfwlist.txt"
o.default		= "/etc/chinadns-ng/gfwlist.txt"
o.inputtitle	= translate("update")

o = s:option(Button, "update_chnroute", translate("PATH"), translate("The update time may be 1-2 minutes, and it may fail."))
o.template		= "cbi/chinadns_button"
o.inputstyle	= "save"
o.placeholder	= "/etc/chinadns-ng/chnroute.ipset"
o.default		= "/etc/chinadns-ng/chnroute.ipset"
o.inputtitle	= translate("update")

o = s:option(Button, "update_chnroute6", translate("PATH"), translate("The update time may be 1-2 minutes, and it may fail."))
o.template		= "cbi/chinadns_button"
o.inputstyle	= "save"
o.placeholder	= "/etc/chinadns-ng/chnroute6.ipset"
o.default		= "/etc/chinadns-ng/chnroute6.ipset"
o.inputtitle	= translate("update")


return m
