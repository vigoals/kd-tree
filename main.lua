require "kdtree/kdtree"

local kdtree = KDTree({maxNum=5})

local buf = {}

for i = 1, 20 do
	local key = torch.rand(2)
	local value = torch.rand(1)

	buf[#buf + 1] = {key=key, value=value}
end

for i = 1, 20 do
	local key = buf[i].key
	local value = buf[i].value

	kdtree:add(key, value)
end

kdtree:print()

for i = 1, 20 do
	local key = buf[i].key
	local value = buf[i].value

	local tmp = kdtree:find(key)
	assert(tmp)
	assert(value:equal(tmp.value))
	print(i .. " found")
end

local buf2 = kdtree:kNearest(buf[1].key, 5)
print("k nearest:")
for i = 1, #buf2 do
	print(i .. "th nearest " .. key2str(buf2[i].key))
end

local key1 = buf[1].key
for i = 1, #buf do
	local key2 = buf[i].key:clone()
	local dist = math.sqrt(key2:clone():csub(key1):pow(2):sum())

	print(key2str(key2) .. "    " .. string.format("%.8f", dist))
end
