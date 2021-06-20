#- ao invés de criar uma matrix com distâncias, eu posso já ir calculando os valores que entram na matrix com 0 e 1 dependendo do cutoff
#- ao função domais vai entrar dentro dessa auto_corr
#- no loop, se a distancia for menor que o cutpff assinalo 1 (true), se não 0(false)



#  function domain_eval!(dist,domain,cutoff)
#    for i in eachindex(dist)
#      if dist[i] <= cutoff
#        domain[i] = true
#      else
#        domain[i] = false
#      end
#    end
#  end





 function dist_eval!(x,y,i,j,d2,dist;corte=4)
   d = sqrt(d2)
   dist[j] = d 
 #  if d <= corte
 #    dist[j] = true
 #  else
 #    dist[j] = false
 #  end
 end




export autocorr_cell 

function autocorr_cell(trajectory::Trajectory)
   
  nprot = length(trajectory.x_solute)  # number of protein atoms 
  nsvt  = length(trajectory.x_solvent) # number of solvent atoms
  nframes = trajectory.nframes         # number of frames

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
 
  cutoff = 4

  for iframe in 1:nframes 
   
    nextframe!(trajectory) # reading coordinates of next frame
    solute    = trajectory.solute        #                
    solvent   = trajectory.solvent       # variables to compute the autocorrelation function   
    x_solute  = trajectory.x_solute      #
    x_solvent = trajectory.x_solvent     #
    sides = getsides(trajectory,iframe)   # box

   # map_pairwise!(f::Function,output,x::AbstractVector,y::AbstractVector,box::Box,lc::LinkedLists)       
 
    #cell list implementation
    lsv  = LinkedLists(nsvt)
    box = Box(sides,cutoff)       
    initlists!(x_solvent, box, lsv)    
   
    map_pairwise!((x,y,i,j,d2,dist) -> dist_eval!(x_solute,x_solvent,i,j,d2,Dist),Dist,x_solvent,box,lsv)
  end
 
#    for iat in 1:nsvt  
#      dist = 10000. 
# 
#    # fazer o CellMapList 
#    for i in 1:nsvt            # loop though solvent atoms
#      # distance
#      dist = 10000.
#
#      dims = x_solvent[i] 
#
#      for p in 1:nprot 
#
#        x_this_solute = viewmol(i,x_solvent,solvent)
#        pt = x_solute[p]
#        D = distance(dims,pt,sides)                  # distance calculation
#
#        # to calculate the protein atom that are at the closest distance to the sovlent  
#        if dist > D
#          dist = D
#        end
#                
#      end
#      Dist[iframe,i] = dist
#    end
#  end



  closetraj(trajectory)
  return Dist, domain, evals, sp, nprot, nsvt, nframes, time

end

