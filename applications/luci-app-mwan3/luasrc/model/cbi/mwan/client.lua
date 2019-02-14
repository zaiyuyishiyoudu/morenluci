local SYS  = require "luci.sys"

local GFW = SYS.exec("cat /etc/mwan3helper/gfw.txt | wc -l")
local CN = SYS.exec("cat /etc/mwan3helper/all_cn.txt | wc -l")
local CT = SYS.exec("cat /etc/mwan3helper/chinatelecom.txt | wc -l")
local CNC = SYS.exec("cat /etc/mwan3helper/unicom_cnc.txt | wc -l")
local CMCC = SYS.exec("cat /etc/mwan3helper/cmcc.txt | wc -l")
local CRTC = SYS.exec("cat /etc/mwan3helper/crtc.txt | wc -l")
local CERNET = SYS.exec("cat /etc/mwan3helper/cernet.txt | wc -l")
local GWBN = SYS.exec("cat /etc/mwan3helper/gwbn.txt | wc -l")
local OTHERNET = SYS.exec("cat /etc/mwan3helper/othernet.txt | wc -l")

m = Map("mwan3helper")
m.title	= translate("MWAN3 Helper")
m.description = translate("MWAN3 Helper generate IPSets")

m:section(SimpleSection).template  = "mwan/mwan3helper_status"

s = m:section(TypedSection, "mwan3helper")
s.addremove = false
s.anonymous = true

o = s:option(Flag, "enabled", translate("Enable GFW IPSet"))
o.rmempty = false
o.description = translate("启用 DNS 防污染并打开GFW IPSet（与SSR的GFW列表模式不能同时开启）")

o = s:option(ListValue, "dns", translate("Anti-pollution DNS Server"))
o:value("208.67.222.222:443", translate("OpenDNS (208.67.222.222)"))
o:value("208.67.220.220:443", translate("OpenDNS (208.67.220.220)"))
o:value("8.8.4.4:53", translate("Google Public DNS (8.8.4.4)"))
o:value("8.8.8.8:53", translate("Google Public DNS (8.8.8.8)"))
o:value("209.244.0.3:53", translate("Level 3 Public DNS (209.244.0.3)"))
o:value("209.244.0.4:53", translate("Level 3 Public DNS (209.244.0.4)"))
o:value("4.2.2.1:53", translate("Level 3 Public DNS (4.2.2.1)"))
o:value("4.2.2.2:53", translate("Level 3 Public DNS (4.2.2.2)"))
o:value("4.2.2.3:53", translate("Level 3 Public DNS (4.2.2.3)"))
o:value("4.2.2.4:53", translate("Level 3 Public DNS (4.2.2.4)"))
o:value("1.1.1.1:53", translate("Cloudflare DNS (1.1.1.1)"))

o = s:option(DummyValue, "gfwlist", translate("GFW列表"))
o.description = string.format(translate("GFW列表数据") ..  "：%s 条，IPSET 名称为 gfwlist", GFW)

o = s:option(DummyValue, "all_cn", translate("中国所有IP地址"))
o.description = string.format(translate("中国所有IP地址路由表数据") ..  "：%s 条, IPSET 名称为 cn", CN)

o = s:option(DummyValue, "chinatelecom", translate("中国电信"))
o.description = string.format(translate("中国电信路由表数据") ..  "：%s 条, IPSET 名称为 ct", CT)

o = s:option(DummyValue, "unicom_cnc", translate("中国联通/网通"))
o.description = string.format(translate("中国联通/网通路由表数据") ..  "：%s 条, IPSET 名称为 cnc", CNC)

o = s:option(DummyValue, "cmcc", translate("中国移动"))
o.description = string.format(translate("中国移动路由表数据") ..  "：%s 条, IPSET 名称为 cmcc", CMCC)

o = s:option(DummyValue, "crtc", translate("中国铁通"))
o.description = string.format(translate("中国铁通路由表数据") ..  "：%s 条, IPSET 名称为 crtc", CRTC)

o = s:option(DummyValue, "cernet", translate("中国教育网"))
o.description = string.format(translate("中国教育网路由表数据") ..  "：%s 条, IPSET 名称为 cernet", CERNET)

o = s:option(DummyValue, "gwbn", translate("长城宽带/鹏博士"))
o.description = string.format(translate("长城宽带/鹏博士") ..  "：%s 条, IPSET 名称为 gwbn", GWBN)

o = s:option(DummyValue, "othernet", translate("中国其他ISP"))
o.description = string.format(translate("中国其他ISP") ..  "：%s 条, IPSET 名称为 othernet", OTHERNET)

return m
