-- Copyright 2014 Roger D <rogerdammit@gmail.com>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.mjpg-streamer", package.seeall)

function index()
	require("luci.i18n")
	if not nixio.fs.access("/etc/config/mjpg-streamer") then
		return
	end

	local page = entry({"admin", "services", "mjpg-streamer"}, cbi("mjpg-streamer"), _("MJPG-streamer"))
	page.i18n = "mjpg-streamer"
	page.dependent = true
	entry({"admin","services","mjpg-streamer","status"},call("act_status")).leaf=true
end

function act_status()
  local e={}
  e.running=luci.sys.call("pgrep mjpg_streamer >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
