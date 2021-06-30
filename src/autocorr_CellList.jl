
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



#function pair_two!(i, j, d2, matrix)
#  d = sqrt(d2)
##  println("distance between $i and $j is = $d")
#  #println("coordenadas em x = $x_solute e y = $x_solvent")
# # matrix[i,j] = d
#end
#
#
## function to find the minimum value saved in the matrix of atoms (Mat)
#function find_min!(M,dist,nframe)
#  min = +Inf
#  for i in 1:length(M[1,:])
#    d = minimum(M[:,i])
#    dist[nframe,i] = d
#  end
#end

export autocorr_cell 

function autocorr_cell(trajectory::Trajectory)
   
  nprot = length(trajectory.x_solute)  # number of protein atoms 
  nsvt  = length(trajectory.x_solvent) # number of solvent atoms
  nframes = trajectory.nframes         # number of frames

  # vector with time - ns 
  delta = 0.01
  time = zeros(nframes)
  t1 = 0. 
  for i in 1:nframes
    t1 = t1 + delta  
    time[i] = t1
  end

  Dist      = zeros(Float64, nframes, nsvt)        # matrix of distances between the atoms 
  domain    = zeros(Float64, nframes, nsvt)        # matrix of correlation obtained from the evaluation of the particle position 
  evals     = zeros(Float64, nframes, nsvt)        # Matrix of the number of events observed
  sp        = zeros(Float64, nframes, nsvt)        # Matrix of the sample space - all possible events 
  cutoff    = 10 # celllistmap parameter
  matrix    = zeros(Float64,nprot, nsvt)


  for iframe in 1:nframes 
    nextframe!(trajectory) # reading coordinates of next frame
    solute    = trajectory.solute        #                
    solvent   = trajectory.solvent       # variables to compute the autocorrelation function   
    x_solute  = trajectory.x_solute      #
    x_solvent = trajectory.x_solvent     #

    # CellLisMap parameters 
    sides = getsides(trajectory,iframe)   # box
    box = Box(sides,cutoff) 

    # Initialize auxiliary linked lists (largest set!)
    cl = CellList(x_solute, x_solvent, box)
  
    # atoms dist - must be allocated and calculated for each frame
    map_pairwise!((x,y,i,j,d2,output) -> push_pair!(i, j, d2, output), matrix, box, cl)

    #println(matrix)
    #find_min!(matrix, Dist, iframe)

  end 
  println(matrix)
  closetraj(trajectory)
#  return Dist, domain, evals, sp, nprot, nsvt, nframes, time
end


















