-- This file is part of XPrivacyLua.

-- XPrivacyLua is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- XPrivacyLua is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with XPrivacyLua.  If not, see <http://www.gnu.org/licenses/>.

-- Copyright 2017-2018 Marcel Bokhorst (M66B)

function before(hook, param)
    local data = param:getArgument(0)
    if data == nil then
        return false
    end

    local intent = getPrivateField(data, 'intent')
    if intent == nil then
        return false
    end

    local action = invokePrivateMethod(intent, 'getAction')
    if action == nil then
        return false
    end

    local match = string.gmatch(hook:getName(), '[^/]+')
    local func = match()
    local name = match()

    if (name == 'notification' and action == 'android.service.notification.NotificationListenerService') then
        param:setResult(nil)
        return true
    else
        return false
    end
end
