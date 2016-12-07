local node = torch.class('KDTreeNode')

function node:__init (args)
	self.maxNum = args.maxNum or 100
	self.split = false
	self.splitDim = 0
	self.splitPoint = nil
	self.dataNum = 0
	self.buf = {}
	self.left = nil
	self.right = nil
end

function node:add (key, value)
	if not self.split then
		self.buf[#self.buf + 1] = {key=key, value=value}

		if #self.buf > self.maxNum then
			self:chooseAndSplit()
		end
	else

	end
end

function node:chooseAndSplit ()
	local keyDim = self.buf[1].key:size(1)

	local tmp = torch.Tensor(#self.buf, keyDim)
	for i = 1, #self.buf do
		tmp[i] = self.buf[i].key:clone()
	end

	local _, dim = tmp:std(1):max(2)
	dim = dim[1]

	local _, sort = tmp:sort(1)
	local k = sort[math.floor(#self.buf/2 + 0.5)][dim]

	local point = tmp[k]
	self:split(dim, point)
end

function node:split (splitDim, splitPoint)
	self.split = true
	self.splitDim = splitDim
	self.splitPoint = splitPoint

	for i = 1, #self.buf do
		local key = self.buf[i].key
		local value = self.buf[i].value

		if not key:equal(splitPoint) then
			if key[splitDim] < splitPoint then
				self.left:add(key, value)
			else
				self.right:add(key, value)
			end
		end
	end

	self.buf = nil
end
