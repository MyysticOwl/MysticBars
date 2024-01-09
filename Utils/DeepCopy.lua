function DeepcopySaveConvertInts(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then
            error("both parameters must be of type table but recieved " ..type(a)..
                    " and " .. type(b));
    else
            for k,v in pairs(a) do
                    -- if the type is a table, we'll need to recurse.
                    if type(v) ~= "table" then
                        local l, y;
                        if ( type( k ) == "number" ) then
                            l = "INTEGER:" .. tostring( k );
                        else
                            l = k;
                        end
                        if ( type( v ) == "number" ) then
                            y = "INTEGER:" .. tostring( v );
                        else
                            y = v;
                        end
                        b[l] = y;
                    else
                        local x = {}
                        self:deepcopySaveConvertInts(v, x);

                        local l;
                        if ( type( k ) == "number" ) then
                            l = "INTEGER:" .. tostring( k );
                        else
                            l = k;
                        end
                        b[l] = x;
                    end       
            end
    end
    return b;
end


function DeepcopyLoadConvertInts(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then
            error("both parameters must be of type table but recieved " ..type(a)..
                    " and " .. type(b));
    else
            for k,v in pairs(a) do
                    -- if the type is a table, we'll need to recurse.
                    if type(v) ~= "table" then
                        local l, y;
                        if ( type( k ) == "string" ) then
                            local temp, count = string.gsub( k, "INTEGER:", "");
                            if ( count > 0 ) then
                                l = tonumber( temp );
                            else
                                l = temp;
                            end
                        else
                            l = k;
                        end
                        if ( type( v ) == "string" ) then
                            local temp, count = string.gsub( v, "INTEGER:", "");
                            if ( count > 0 ) then
                                y = tonumber( temp );
                            else
                                y = temp;
                            end
                        else
                            y = v;
                        end
                        b[l] = y;
                    else
                        local x = {}
                        self:deepcopyLoadConvertInts(v, x);

                        local l;
                        if ( type( k ) == "string" ) then
                            local temp, count = string.gsub( k, "INTEGER:", "");
                            if ( count > 0 ) then
                                l = tonumber( temp );
                            else
                                l = temp;
                            end
                        else
                            l = k;
                        end
                        b[l] = x;
                    end       
            end
    end
    return b;
end

function Deepcopy(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then
            error("both parameters must be of type table but recieved " ..type(a)..
                    " and " .. type(b));
    else
            for k,v in pairs(a) do
                    -- if the type is a table, we'll need to recurse.
                    if type(v) ~= "table" then
                            b[k] = v;
                    else
                            local x = {}
                            self:deepcopy(v, x);
                            b[k] = x;
                    end       
            end
    end
    return b;
end
