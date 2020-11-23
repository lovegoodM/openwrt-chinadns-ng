-- Licensed to the public under the GNU General Public License v3.

module("luci.controller.chinadns-ng", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/chinadns-ng") then
		return
	end

	entry({"admin", "services", "chinadns-ng"}, cbi("chinadns-ng"), _("ChinaDNS-NG"), 70).dependent = true
	entry({"admin", "services", "chinadns-ng", "status"},call("act_status")).leaf=true
end

function act_status()
  local e={}
  e.running=luci.sys.exec('pgrep chinadns-ng' .. 
  " | awk 'END{print NR}' | tr -d '\\n'")
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
