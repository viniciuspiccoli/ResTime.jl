using CellListMap, StaticArrays

function push_pair!(i,j,d2,matrix)
  d = sqrt(d2)
  matrix[i,j] = d 
  return matrix
end

function find_min!(M,dist,nframe)
  min = +Inf
  for i in 1:length(M[1,:])
    a = -Inf
    data = M[:,i]
    for h in 1:length(data)
      if a < data[h] && data[h] != 0
        a = data[h]
      end
    end
    if a == -Inf
      a = 0.
    end
    dist[nframe,i] = a
  end
end




let

  N1=10
  N2=80
  sides = [250,250,250]
  cutoff = 10.
  box = Box(sides,cutoff)
  matrix = zeros(N1,N2)
  
  nframes   = 10
  Dist      = zeros(nframes,N2) 
  
 
  
  for i in 1:nframes
  
    # Particle positions
    x = [ box.sides .* rand(SVector{3,Float64}) for i in 1:N1 ]
    y = [ box.sides .* rand(SVector{3,Float64}) for i in 1:N2 ]
    
    # Initialize auxiliary linked lists (largest set!)
    cl = CellList(x,y,box)  
    matrix = map_pairwise!((x,y,i,j,d2,output) -> push_pair!(i,j,d2,output),matrix,box,cl)
  
    #println(matrix)
    find_min!(matrix, Dist, i)  

  end

  println(Dist)



end











