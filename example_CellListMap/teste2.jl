using CellListMap, StaticArrays

# System properties
n = 100_000
N = n
sides = [250,250,250]
cutoff = 10

# Initialize linked lists and box structures
box = Box(sides,cutoff)
# masses
const mass = rand(N)

# Particle positions
x = [ box.sides .* rand(SVector{3,Float64}) for i in 1:n ]

cl = CellList(x,box)

# Function to be evalulated for each pair 
function potential(x,y,i,j,d2,u,mass)
  d = sqrt(d2)
  u = u - 9.8*mass[i]*mass[j]/d
  return u
end

# Run pairwise computation
u = map_pairwise!((x,y,i,j,d2,u) -> potential(x,y,i,j,d2,u,mass),0.0,box,cl)
