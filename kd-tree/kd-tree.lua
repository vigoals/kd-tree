local kdtree = torch.class('KDTree')

function kdtree:__init ()
	self.tree = {}
end
