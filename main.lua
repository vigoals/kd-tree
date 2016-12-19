require "kdtree/kdtree"

local kdtree = KDTree({maxNum=5})

for i = 1, 10 do
	local key = torch.rand(2)
	local value = torch.rand(1)

	kdtree:add(key, value)
end

kdtree:print()
