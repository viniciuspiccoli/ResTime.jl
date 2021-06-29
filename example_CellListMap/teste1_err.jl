using CellListMap, StaticArrays

function pair_two!(i, j, d2, matrix)
  d = sqrt(d2)
  matrix[i,j] = d
  return d
end

function find_min!(M,dist,nframe)
  min = +Inf
  for i in 1:length(M[1,:])
    d = maximum(M[:,i])
    dist[nframe,i] = d
  end
end


function run()
  N1        = 500                                 # solute
  N2        = 8000                                 # sovent
  nframes   = 1                                  # number of frames
  Dist      = Array{Float64}(undef,nframes,N2)   # nframes x nsolvents 
  sides     = [200,200,200]                       
  cutoff    = 10
  box       = Box(sides,cutoff)                  
 # matrix = Array{Float64}(undef, N1, N2)  
  matrix = zeros(N1, N2)


  for h in 1:nframes
    x = [ box.sides .* rand(SVector{3,Float64}) for i in 1:N1 ]
    y = [ box.sides .* rand(SVector{3,Float64}) for i in 1:N2 ]
    cl = CellList(x,y,box)
    #matrix = zeros(N1,N2)
    matrix = map_pairwise!((x, y, i, j, d2, output) -> pair_two!(i, j, d2, output), matrix, box, cl)
   # println(matrix)
   # find_min!(matrix, Dist, h)  
  end
  println("----------------------------------------------------------------")
  println(matrix)
end



run()
