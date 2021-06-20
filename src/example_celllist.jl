# Function to be evalulated for each pair: push pair if d<cutoff
function push_pair!(i,j,d2,pairs,cutoff)
  d = sqrt(d2)
  if d < cutoff
    push!(pairs,(i,j,d))
  end
  return pairs
end

# Reduction function
function reduce_pairs(pairs,pairs_threaded)
  pairs = pairs_threaded[1]
  for i in 2:nthreads()
    append!(pairs,pairs_threaded[i])
  end
  return pairs
end

# Initialize output
pairs = Tuple{Int,Int,Float64}[]

# Run pairwise computation
pairs = map_pairwise!(
  (x,y,i,j,d2,pairs) -> push_pair!(i,j,d2,pairs,cutoff),
  pairs,x,box,lc,
  reduce=reduce_pairs,
  parallel=parallel
)
