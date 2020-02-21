local function validate(text)
  -- return true if input is valid email format
  return not not (text:match("^[%w.]+%+*%w+@%w+%.%w+$"))
 end

local function uniqueEmails(lst)
  local count = 0
  local finalList = {}
  for _, email in ipairs(lst) do
    if validate(email) then
      -- find position of @
      local atpos = email:find("[^%@]+$")
      -- extract string before @
      local acct = email:sub(1, (atpos - 2))
      -- find position of +
      local pluspos = acct:find("[^%+]+$")
      -- extract string before + if it exists
      acct = pluspos and pluspos > 1 and acct:sub(1, (pluspos -2)) or acct
      -- remove all .
      acct = string.gsub(acct,"%.","")
      -- extract string after @
      local domain = email:sub(atpos, #email)
      -- increment count if we haven't seen this email account yet
      if finalList[acct .. domain] == nil then
        count = count + 1
        finalList[acct .. domain] = true
      end
    end
  end
  return count
end

local emails = {'test.email@gmail.com', 'test.email+spam@gmail.com', 'testemail@gmail.com', 'c+dbg@gm.com'}

local count = uniqueEmails(emails)
print("Unique Emails = " .. count)
