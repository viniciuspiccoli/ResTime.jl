  function sample_space!(sp,domain,nsvt,nframes)
    for i in 1:nsvt  
      dt = 0 
      for t in 1:nframes 
        for j in 1:nframes  
          if ((j + dt) <= nframes )
            if domain[j,i] == 1  
              sp[t,i] = sp[t,i] + 1  
            end      
          end 
        end
        dt = dt + 1
      end 
    end
  end
