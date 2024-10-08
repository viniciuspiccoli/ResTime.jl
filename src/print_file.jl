
# outputfile for 4 components of the system - useful for electrolyte solutions with more than one salt
function writefile(il::String,c::String,time, prob_an, prob_an2, prob_cat, prob_wat, cutoff::String)
  file = open("timecorr-$il-$c-$(cutoff).dat","w")  
  @printf(file,"# Data for survivor probability calculation - %s \n", il)
  @printf(file,"# 1 - Simulation time (ns)\n")
  @printf(file,"# 2 - ANION1 timecoorelation function\n")
  @printf(file,"# 3 - ANION2 timecorrelation function\n")
  @printf(file,"# 4 - CATION timecorrelation function\n")
  @printf(file,"# 5 - WATER  timecorrelation function\n")  
  for i in 1:length(time)
    @printf(file,"%f %f %f %f %f\n",time[i],prob_an[i],prob_an2[i], prob_cat[i], prob_wat[i])
  end
end

# outputfile for 3 components of the system - useful for electrolyte solutions
function writefile(il::String,c::String,time, prob_an, prob_cat, prob_wat, cutoff::String)
  file = open("timecorr-$il-$c-$(cutoff).dat","w") 
  @printf(file,"# Data for survivor probability calculationi - %s \n", il)
  @printf(file,"# 1 - Simulation time (ns)\n")
  @printf(file,"# 2 - ANION  timecoorelation\n")
  @printf(file,"# 3 - CATION timecoorelation\n")
  @printf(file,"# 4 - WATER  timecoorelation\n")  
  for i in 1:length(time)
    @printf(file,"%f %f %f %f\n",time[i],prob_an[i], prob_cat[i], prob_wat[i])
  end
end

# output file for two components of the system (solvent)
function writefile(il::String,c::String,time, prob_an, prob_cat, name1::String, name2::String, cutoff::String)
  file = open("timecorr-$il-$c-ions-$cutoff.dat","w")
  @printf(file,"# Data for survivor probability calculation\n")
  @printf(file,"# 1 - Simulation time (ns)\n")
  @printf(file,"# 2 - %s probability survivor function\n", name1)
  @printf(file,"# 3 - %s probability survivor function\n", name2)  
  for i in 1:length(time)
    @printf(file,"%f %f %f\n",time[i],prob_an[i], prob_cat[i])
  end
end

# output file for one component of the system
function writefile(il::String,c::String,time, prob_wat, name1::String, cutoff::String)
  file = open("timecorr-$il-$c-water-$cutoff.dat","w")
  @printf(file,"# Data for survivor probability calculation\n")
  @printf(file,"# 1 - Simulation time (ns)\n")
  @printf(file,"# 2 - %s  timecorrelation function\n", name1)  
  for i in 1:length(time)
    @printf(file,"%f %f\n", time[i], prob_wat[i])
  end
end

