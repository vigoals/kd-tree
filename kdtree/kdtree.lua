require "kd-tree/kdtreeNode"

local kdtree = torch.class('KDTree')

function kdtree:__init (args)
	self.maxNum = args.maxNum or 100
	self.tree = KDTreeNode({maxNum=self.maxNum})
end

function kdtree:add (key, value)
	assert(key:dim() == 1)
	self.tree:add(key, value)
end

function kdtree:find (key)
	assert(key:dim() == 1)
	return self.tree:find(key)
end

function kdtree:kNearest (key, k)
	assert(key:dim() == 1)
	local ansBuf = {}
	--kdtreeDFS(self.tree, key, k, ansBuf)
	return ansBuf
end

function kdtree:print ()
	self.tree:print("root")
end
