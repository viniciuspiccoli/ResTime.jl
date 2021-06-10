
function writefile(il::String,c::String,time, prob_an, prob_an2, prob_wat, prob_cat)

  file = open("timecorr-$il-$c.dat","w")
  
  @printf(file,"# Data for survivor probability calculation\n")
  @printf(file,"# 1 - Simulation time (ns)\n")
  @printf(file,"# 2 - ANION  timecorrelation function\n")
  @printf(file,"# 3 - CATION timecorrelation function\n")
  @printf(file,"# 4 - WATER  timecorrelation function\n")
  @printf(file,"# 5 - ANION2 timecorrelation function\n")
  
  for i in 1:length(time)
    @printf(file,"%f %f %f %f %f\n",time[i],prob_an[i],prob_an2[i], prob_cat[i], prob_wat[i])
  end

end

function writefile(il::String,c::String,time, prob_an, prob_wat, prob_cat)

  file = open("timecorr-$il-$c.dat","w")
  
  @printf(file,"# Data for survivor probability calculation\n")
  @printf(file,"# 1 - Simulation time (ns)\n")
  @printf(file,"# 2 - ANION  timecorrelation function\n")
  @printf(file,"# 3 - CATION timecorrelation function\n")
  @printf(file,"# 4 - WATER  timecorrelation function\n")
  
  for i in 1:length(time)
    @printf(file,"%f %f %f %f\n",time[i],prob_an[i], prob_cat[i], prob_wat[i])
  end

end


function writefile(il::String,c::String,time, prob_an, prob_cat)

  file = open("timecorr-$il-$c-ions.dat","w")
  
  @printf(file,"# Data for survivor probability calculation\n")
  @printf(file,"# 1 - Simulation time (ns)\n")
  @printf(file,"# 2 - ANION  timecorrelation function\n")
  @printf(file,"# 3 - CATION timecorrelation function\n")
  
  for i in 1:length(time)
    @printf(file,"%f %f %f\n",time[i],prob_an[i], prob_cat[i])
  end

end



function writefile(il::String,c::String,time, prob_an, prob_cat,name::String)

  file = open("timecorr-$il-$c-$name-ions.dat","w")
  
  @printf(file,"# Data for survivor probability calculation\n")
  @printf(file,"# 1 - Simulation time (ns)\n")
  @printf(file,"# 2 - ANIONS  timecorrelation function\n")
  @printf(file,"# 3 - CATION timecorrelation function\n")
  
  for i in 1:length(time)
    @printf(file,"%f %f %f\n",time[i],prob_an[i], prob_cat[i])
  end

end



#function writefile(il::String,c::String,time, prob_an, prob_an2, prob_cat)
#
#  file = open("timecorr-$il-$c-ions.dat","w")
#  
#  @printf(file,"# Data for survivor probability calculation\n")
#  @printf(file,"# 1 - Simulation time (ns)\n")
#  @printf(file,"# 2 - DCA  timecorrelation function\n")
#  @printf(file,"# 2 - BF4  timecorrelation function\n")
#  @printf(file,"# 3 - EMIM timecorrelation function\n")
#  
#  for i in 1:length(time)
#    @printf(file,"%f %f %f %f\n",time[i],prob_an[i], prob_an2[i], prob_cat[i])
#  end
#
#end


function writefile(il::String,c::String,time, prob_wat)

  file = open("timecorr-$il-$c-water.dat","w")
  
  @printf(file,"# Data for survivor probability calculation\n")
  @printf(file,"# 1 - Simulation time (ns)\n")
  @printf(file,"# 2 - WATER  timecorrelation function\n")
  
  for i in 1:length(time)
    @printf(file,"%f %f\n", time[i], prob_wat[i])
  end

end



















