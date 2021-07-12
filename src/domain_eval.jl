
#=dist matrix obtained from autocorr_CellList is different from autocorr. Thus,
in "cell_matrix" all the possible values bigger than the celllist cutoff (and, therefore, bigger than the cutoff of the residence time)
will be zero, because the method of liked list did not calcute these distances.
=#
  function domain_eval!(dist,domain,cutoff)
    for i in eachindex(dist)
      if dist[i] <= cutoff  
        domain[i] = true 
      else
        domain[i] = false
      end
    end
  end   


