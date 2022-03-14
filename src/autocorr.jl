  using PDBTools  #, ComplexMixtures
  function autocorr(trajectory::Trajectory)
  
    # number of atoms
    nprot = length(trajectory.x_solute) 
    nsvt  = length(trajectory.x_solvent)
    nframes = trajectory.nframes
  
    # vector with time - ns
    delta = 0.01
    time  = [delta*i for i in 0:nframes-1]
  #  time = zeros(nframes)
  #  t1 = 0. 
  #  for i in 1:nframes
  #    t1 = t1 + delta  
  #    time[i] = t1
  #  end
  
    # matrix of distances, absorptions, number of events and sample space
    Dist      = Array{Float64}(undef,nframes,nsvt)
    domain    = zeros(Float64, nframes, nsvt)
    evals     = zeros(Float64, nframes, nsvt)
    sp        = zeros(Float64, nframes, nsvt)  
   
    for iframe in 1:nframes 
     
      # reading coordinates of next frame
      nextframe!(trajectory)
         
      # variables to compute the autocorrelation function   
      solute    = trajectory.solute                        
      solvent   = trajectory.solvent
      x_solute  = trajectory.x_solute
      x_solvent = trajectory.x_solvent
  
      # box
      sides = getsides(trajectory,iframe)
 
      for i in 1:nsvt            # loop though solvent atoms
        # distance
        dist = +Inf
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

