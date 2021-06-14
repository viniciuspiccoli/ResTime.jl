
export autocorr 

function autocorr(trajectory::Trajectory)
   
  nprot = length(trajectory.x_solute)  # number of protein atoms 
  nsvt  = length(trajectory.x_solvent) # number of solvent atoms
  nframes = trajectory.nframes         # number of frames
  total = nprot + nsvt                 # number of atoms in the box 

  # vector with time - ns 
  delta = 0.01
  time = zeros(nframes)
  global t1 = 0. 
  for i in 1:nframes
    global t1 = t1 + delta  
    time[i] = t1
  end

  Dist      = Array{Float64}(undef,nframes,nsvt)   # matrix of distances between the atoms 
  domain    = zeros(Float64, nframes, nsvt)        # matrix of correlation obtained from the evaluation of the particle position 
  evals     = zeros(Float64, nframes, nsvt)        # Matrix of the number of events observed
  sp        = zeros(Float64, nframes, nsvt)        # Matrix of the sample space - all possible events
 
  cutoff = 10

  for iframe in 1:nframes 
   
    nextframe!(trajectory) # reading coordinates of next frame
    solute    = trajectory.solute        #                
    solvent   = trajectory.solvent       # variables to compute the autocorrelation function   
    x_solute  = trajectory.x_solute      #
    x_solvent = trajectory.x_solvent     #
    sides = getsides(trajectory,iframe)   # box

   # map_pairwise!(f::Function,output,x::AbstractVector,y::AbstractVector,box::Box,lc::LinkedLists)       
 
    #cell list implementation
    lv  = LinkedLists(nsvt)
    box = Box(sides,cutoff)  
     
    initlists!(x_solute, box, lp)    







    # fazer o CellMapList 
    for i in 1:nsvt            # loop though solvent atoms
      # distance
      dist = 10000.

      dims = x_solvent[i] 

      for p in 1:nprot 

        x_this_solute = viewmol(i,x_solvent,solvent)
        pt = x_solute[p]
        D = distance(dims,pt,sides)                  # distance calculation

        # to calculate the protein atom that are at the closest distance to the sovlent  
        if dist > D
          dist = D
        end
                
      end
      Dist[iframe,i] = dist
    end
  end



  closetraj(trajectory)
  return Dist, domain, evals, sp, nprot, nsvt, nframes, time

end

