

function push_pair!(i,j,d2,matrix)
  d = sqrt(d2)
  matrix[i,j] = d
  return matrix
end

function add_inf!(matrix)
  for i in eachindex(matrix)
    if matrix[i] == 0  
      matrix[i]=+Inf  
    end
  end
end

#function find_data!(matrix, dist, nframe)
#  for i in 1:length(matrix[1,:])            # loop though number of solvents
#    data = matrix[:,i]                      # all distances between protein atoms and the ith solvent
#    dist[nframe,i] = minimum(data)
#  end
#end

function find_data!(matrix, dist, nframe)
  for i in 1:length(matrix[1,:])            # loop though number of solvents                      
    dist[nframe,i] = minimum(@view(matrix[:,i])) # all distances between protein atoms and the ith solvent
  end
end

function autocorr_cell(trajectory::Trajectory)
   
  nprot = length(trajectory.x_solute)  # number of protein atoms 
  nsvt  = length(trajectory.x_solvent) # number of solvent atoms
  nframes = trajectory.nframes         # number of frames

  # vector with time - ns 
  delta = 0.01
  time  = [ delta*i for i in 0:nframes ]

  #time = zeros(nframes)
  #t1 = 0. 
  #for i in 1:nframes
  #  t1 = t1 + delta  
  #  time[i] = t1
  #end

  Dist      = zeros(Float64, nframes, nsvt)        # matrix of distances between the atoms 
  domain    = zeros(Float64, nframes, nsvt)        # matrix of correlation obtained from the evaluation of the particle position 
  evals     = zeros(Float64, nframes, nsvt)        # Matrix of the number of events observed
  sp        = zeros(Float64, nframes, nsvt)        # Matrix of the sample space - all possible events 
  cutoff    = 30                                   # celllistmap parameter
  
  #if nprot > nsvt
  #  matrix    = zeros(Float64,nsvt, nprot)
  #else
    matrix    = zeros(Float64,nprot, nsvt)
  #end

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
   
    add_inf!(matrix)

   # if nprot > nsvt 
   #   new = transpose(matrix) # due to the CellListMap package, this must be performed to avoid boundserror
   #   find_data!(new, Dist, iframe)
   # else
      find_data!(matrix, Dist, iframe)
   # end

  end
  closetraj(trajectory)
  return Dist, domain, evals, sp, nprot, nsvt, nframes, time
end


















