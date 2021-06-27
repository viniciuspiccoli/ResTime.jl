# input for map_pairwise!

function pair_two!(x, y, i, j, d2, output)
  d = sqrt(d2)
  output[i,j] = d
end

# acho que essa função está errada
function pair_dist!(x, y, i, j, sides, output)
  dims = x[i]
  pt   = y[j]
  d0 = ResTime.distance(dims, pt, sides)
  output[i,j]  = d0
end

# function to find the minimum value saved in the matrix of atoms (Mat)
function find_min!(M,dist,nframe)
  min = +Inf
  for i in 1:length(M[1,:])
    d = minimum(M[:,i])
    dist[nframe,i] = d
  end
end

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

  Dist      = Array{Float64}(undef,nframes,nsvt)   # matrix of distances between the atoms 
#  Dist2     = Array{Float64}(undef,nframes,nsvt)   # matrix of distances between the atoms 
  domain    = zeros(Float64, nframes, nsvt)        # matrix of correlation obtained from the evaluation of the particle position 
  evals     = zeros(Float64, nframes, nsvt)        # Matrix of the number of events observed
  sp        = zeros(Float64, nframes, nsvt)        # Matrix of the sample space - all possible events 
  cutoff    = 10 # celllistmap parameter

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
    Mat = Array{Float64}(undef, nprot, nsvt)
    map_pairwise!((x,y,i,j,d2,output) -> pair_two!(x_solute, x_solvent, i, j, d2, Mat), Mat, box, cl)
    find_min!(Mat, Dist, iframe)

    # atoms dist - must be allocated and calculated for each frame
    #Mat2 = Array{Float64}(0.0, nprot, nsvt)
    #map_pairwise!((x,y,i,j,d2,output) -> (i, j, d2, Mat2), Mat2, box, cl)
    #find_min!(Mat2, Dist2, iframe)

  end 
  closetraj(trajectory)
  return Dist, domain, evals, sp, nprot, nsvt, nframes, time
end


















