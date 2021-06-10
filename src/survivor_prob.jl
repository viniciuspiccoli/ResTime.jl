#  function survivor_prob(evals,sp,nsvt)
#  
#    n = size(evals)[1]
#    l = size(evals)[2]
#    pdt = zeros(Float64, n, l)
#
#    for i in 1:l
#      for j in 1:n
#        if evals[j,i] == 0
#          pdt[j,i] = 0
#        else
#          pdt[j,i] = evals[j,i] / sp[j,i]
#        end 
#      end
#    end
#    final = sum(pdt,dims=2) / nsvt
#    return final
#
#  end
#

  function survivor_prob(evals,sp,nsvt)
    ev = sum(evals,dims=2) / nsvt  
    ea = sum(sp, dims=2) / nsvt
   
    l     = length(ev)
    final = zeros(Float64, l) 

    for i in 1:l
      if ev[i]==0
        final[i] = 0.
      else
        final[i] = ev[i] / ea[i]
      end
    end

   # final = ev ./ ea   
    return final
  end

