  function domain_eval!(dist,domain,cutoff)
    for i in eachindex(dist)
      if dist[i] <= cutoff  
        domain[i] = true 
      else
        domain[i] = false
      end
    end
  end   
