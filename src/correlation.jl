 function correlation(traj::Trajectory,cutoff::Float64)
   # main function - calculation of the matrix distance   
   dist, domain, evals, sp, nprot, nsvt, nframes, stime = autocorr(traj) 
   # evaluation if the solvent is inside (or not) of the "protein domain"   
   domain_eval!(dist,domain,cutoff) 
   # evaluation of the number of events existing in the domain matrix     
   events!(domain,evals,nframes,nsvt)
   # sample space
   sample_space!(sp, domain, nsvt, nframes)
   prob_sur = survivor_prob(evals, sp, nsvt) 
   return stime, prob_sur
 end


 function correlation_cell(traj::Trajectory,cutoff::Float64)
   # main function - calculation of the matrix distance   
   dist, domain, evals, sp, nprot, nsvt, nframes, stime = autocorr_cell(traj) 
   # evaluation if the solvent is inside (or not) of the "protein domain"   
   domain_eval!(dist,domain,cutoff) 
   # evaluation of the number of events existing in the domain matrix     
   events!(domain,evals,nframes,nsvt)
   # sample space
   sample_space!(sp, domain, nsvt, nframes)
   prob_sur = survivor_prob(evals, sp, nsvt) 
   return stime, prob_sur
 end
