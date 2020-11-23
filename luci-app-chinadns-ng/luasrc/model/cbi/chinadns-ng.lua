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

o = s:option(Value, "execpara", translate("Startup parameters"))
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

o = s:option(Value, "s_execpara", translate("Startup parameters"))
-- o.optional    = true
o.datatype    = "string"
o.rmempty     = true
o:depends("s_enable", 1)


o = s:option(Button, "updata_chnlist", translate("update chnlist"), translate("The file is in /etc/chinadns-ng/chnlist.txt"))
o.inputstyle = "save"
function o.write(e, e)
    os.execute("[ -x '/etc/chinadns-ng/update-chnlist.sh' ] && /etc/chinadns-ng/update-chnlist.sh /etc/chinadns-ng/chnlist.txt >/dev/null 2>&1 &")
end

o = s:option(Button, "updata_gfwlist", translate("update gfwlist"), translate("The file is in /etc/chinadns-ng/gfwlist.txt"))
o.inputstyle = "save"
function o.write(e, e)
    os.execute("[ -x '/etc/chinadns-ng/gfwlist2dnsmasq.sh' ] && /etc/chinadns-ng/gfwlist2dnsmasq.sh -l -o /etc/chinadns-ng/gfwlist.txt >/dev/null 2>&1 &")
end

o = s:option(Button, "updata_chnroute", translate("update chnroute"), translate("The file is in /etc/chinadns-ng/chnroute.ipset"))
o.inputstyle = "save"
function o.write(e, e)
    os.execute("[ -x '/etc/chinadns-ng/update-chnroute.sh' ] && /etc/chinadns-ng/update-chnroute.sh /etc/chinadns-ng/chnroute.ipset >/dev/null 2>&1 &")
end

o = s:option(Button, "updata_chnroute6", translate("update chnroute6"), translate("The file is in /etc/chinadns-ng/chnroute6.ipset"))
o.inputstyle = "save"
function o.write(e, e)
    os.execute("[ -x '/etc/chinadns-ng/update-chnroute6.sh' ] && /etc/chinadns-ng/update-chnroute6.sh /etc/chinadns-ng/chnroute6.ipset >/dev/null 2>&1 &")
end

return m
