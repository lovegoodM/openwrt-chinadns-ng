-- Licensed to the public under the GNU General Public License v3.

module("luci.controller.chinadns-ng", package.seeall)
require("luci.i18n")

function index()
	if not nixio.fs.access("/etc/config/chinadns-ng") then
		return
	end

	entry({"admin", "services", "chinadns-ng"}, cbi("chinadns-ng"), _("ChinaDNS-NG"), 70).dependent = true
	entry({"admin", "services", "chinadns-ng", "status"}, call("act_status")).leaf=true
	entry({"admin", "services", "chinadns-ng", "update"}, call("act_update")).leaf=true
end

function act_status()
	local e={}
	e.running=luci.sys.exec('pgrep chinadns-ng' .. 
		" | awk 'END{print NR}' | tr -d '\\n'")
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end

function act_update()
	local cfgre, cmdre
	local cfg = luci.http.formvalue("cfg")
	local path = luci.http.formvalue("path")
	if not isempty(cfg) and not isempty(path) then
		cfgre = (string.gsub(cfg, "^[%a%d]+%.", "uci set "))
		cfgre = command(cfgre .. "=" .. path .. " && uci commit")
	else
		write_json(0, luci.i18n.translate("Update failed"))
		return
	end

	if dir_exists(path) then
		write_json(0, luci.i18n.translate("This is a directory"))
	else
		sh_name = (string.gsub(cfg, "^.*%.", ""):gsub("%_", "%-"))
		if sh_name == "gfwlist2dnsmasq" then
			cmdre = command("[ -x '/etc/chinadns-ng/".. sh_name ..".sh' ] && /etc/chinadns-ng/".. sh_name ..".sh -l -o " .. path .. " >/dev/null 2>&1")
		else
			cmdre = command("[ -x '/etc/chinadns-ng/".. sh_name ..".sh' ] && /etc/chinadns-ng/".. sh_name ..".sh " .. path .. " >/dev/null 2>&1")
		end
		if cmdre then
			write_json(1, luci.i18n.translate("Update completed"))
		else
			write_json(0, luci.i18n.translate("Update failed"))
		end
	end
end

function isempty(s)
	return s == nil or s == ''
end

function file_exists(path)
	local file = os.execute("[ -f "..path.." ]")
	return file == 0
end

function dir_exists(path)
	local file = os.execute("[ -d "..path.." ]")
	return file == 0
end

function command(cmd)
	local ru = os.execute(cmd)
	return ru == 0
end

function write_json(mode, e)
	local result = {}
	if isempty(e) then
		e = ""
	end
	if mode == 1 then
		result.code = 1
		result.info = e
	else
		result.code = 0
		result.info = luci.i18n.translate("error") .. ": " .. e
	end
	luci.http.prepare_content("application/json")
	luci.http.write_json(result)
end