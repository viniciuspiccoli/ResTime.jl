  import LinearAlgebra

  function events!(domain, evals, nframes, nsvt)
    for i in 1:nsvt
      @inbounds for dt in nframes-1:-1:0 
        evals[dt + 1, i] = LinearAlgebra.dot(@view(domain[1:nframes-dt,i]),@view(domain[dt+1:nframes,i])) 
      end
    end
  end
