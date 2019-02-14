-- Copyright 2008 Yanira <forum-2008@email.de>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.hd_idle", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/hd-idle") then
		return
	end

	local page

	page = entry({"admin", "services", "hd_idle"}, cbi("hd_idle"), _("HDD Idle"), 60)
	page.dependent = true
	entry({"admin","services","hd_idle","status"},call("act_status")).leaf=true
end

function act_status()
  local e={}
  e.running=luci.sys.call("pgrep hd-idle >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
