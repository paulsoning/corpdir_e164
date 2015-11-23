M = {}
function M.inbound_SUBSCRIBE(msg)
    local uriStringFrom = msg:getUri("FROM")
    if uriStringFrom
    then
        local uriF = sipUtils.parseUri(uriStringFrom)
        if uriF
        then
            local user = uriF:getUser()
            local Fhost = uriF:getHost()
            local userformat = string.gsub(user, "%%20", "")
            local uriStringTo = msg:getUri("TO")
            if uriStringTo
            then
                local uriT = sipUtils.parseUri(uriStringTo)
                if uriT
                then
                    local Thost = uriT:getHost()
                    msg:setRequestUri("sip:" .. userformat .. "@" .. Thost)
                    msg:modifyHeader("TO", "<sip:" .. userformat .. "@" .. Thost .. ">")
                    msg:modifyHeader("FROM", "<sip:" .. userformat .. "@" .. Fhost .. ">")
                end
            end
        end
    end
end
return M
