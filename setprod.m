function C = setprod(varargin)

args = varargin;

if any([cellfun('isclass',args,'cell') cellfun('isclass',args,'struct')])
    error(' SETPROD only supports numeric/character arrays ')
end

n = nargin;

[F{1:n}] = ndgrid(args{:});

for i=n:-1:1
    G(:,i) = F{i}(:);
end

C = unique(G , 'rows');