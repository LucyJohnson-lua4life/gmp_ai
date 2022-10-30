local script_time = {}

function script_time.getNowInSeconds()
    return os.time()
end

function script_time.getNowInMs()
    return GetTickCount() 
end

return script_time