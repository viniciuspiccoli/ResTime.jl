using CellListMap, StaticArrays

function push_pair!(i,j,d2,matrix)
  d = sqrt(d2)
  matrix[i,j] = d 
  return matrix
end


let

  N1=500
  N2=8000
  sides = [250,250,250]
  cutoff = 10.
  box = Box(sides,cutoff)
  matrix = zeros(N1,N2)
  
  nframes = 1000
  
  
  for i in 1:nframes
  
    # Particle positions
    x = [ box.sides .* rand(SVector{3,Float64}) for i in 1:N1 ]
    y = [ box.sides .* rand(SVector{3,Float64}) for i in 1:N2 ]
    
    # Initialize auxiliary linked lists (largest set!)
    cl = CellList(x,y,box)  
    matrix = map_pairwise!((x,y,i,j,d2,output) -> push_pair!(i,j,d2,output),matrix,box,cl)
  
    #println(matrix)
  
  end




end











