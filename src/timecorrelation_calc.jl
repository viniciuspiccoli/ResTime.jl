# function that only works for my systems o.O

```
il :: Folder with all simulations for one il
main_dir :: Directory with all ILs
conc :: Concentrations

```
  export restime_calculation 
  function restime_calculation(il::String, main_dir::String, conc::String, file::String, cutoff)
    
    cd("$main_dir")
     
    if length(il) == 10   
       
      solute  = "protein"
      atoms   = PDBTools.readPDB(file)
      
      #protein selection
      sel0    = PDBTools.select(atoms,solute)    
      protein = ResTime.Selection(sel0, nmols=1)  # Selection for the calculation of time-correlation function / nmols = 1 (one protein)
   
      #println("passou da seleção do soluto")
      # components of the system
      cat = il[1:3]

      if il[5:7] == "DCA"
        an1 = "name N3A"
      elseif il[5:7] == "BF4"
        an1 = "name B"
      elseif il[5:7] == "NO3"
        an1 = "name N and resname NO3"
      end 
      

      

      if il[8:10] == "DCA"    
        an2 = "name N3A"     
      elseif il[8:10] == "BF4"
        an2 = "name B"
      elseif il[8:10] == "NO3"
        an2 = "name N and resname NO3"     
      end 
               


      # anion selection
      sel1     = PDBTools.select(atoms, an1)
      anion1   = ResTime.Selection(sel1,natomspermol=1)     
      #println("passou da seleção do ânion1 ")

      # anion selection
      sel2    = PDBTools.select(atoms, an2)
      anion2   = ResTime.Selection(sel2,natomspermol=1)  
      #println("passou da seleção do ânion2 ")

      # cation selection
      sel3    = PDBTools.select(atoms,"name LP and resname $cat")
      cation  = ResTime.Selection(sel3,natomspermol=1)     
      #println("passou da seleção do cation ")


      # water selection
      sel4    = PDBTools.select(atoms,"name OW and resname SOL")
      water   = ResTime.Selection(sel4,natomspermol=1)     
      
      #cutoff = 3.5 # cutoff based on MDDFs
      
      # time-correlation calculation for anion1
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion1, format="XTC")
      time_an1, prob_an1 = ResTime.corr_bench(trajectory,cutoff)

      #println("passou da traj anion 1 ")     


      # time-correlation calculation for anion2
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion2, format="XTC")
      time_an2, prob_an2 = ResTime.corr_bench(trajectory,cutoff) 

      #println("passou da traj anion 2 ")


      # time-correlation calculation for cation
      trajectory = ResTime.Trajectory("processed.xtc", protein, cation, format="XTC")
      time_cat, prob_cat = ResTime.corr_bench(trajectory,cutoff)
      
      # time-correlation calculation for WATER
      trajectory = ResTime.Trajectory("processed.xtc", protein, water, format="XTC")
      time_wat, prob_wat = corr_bench(trajectory,cutoff)
     
      #println("passou da traj cation ")


      if time_an1 ≈ time_cat && time_an1 ≈  time_wat && time_cat ≈ time_wat && time_an2 ≈ time_an1
        println("esta tudo ok!")
      end
      
      # Print the result in a file
      ResTime.writefile(il, conc, time_an1, prob_an1, prob_an2, prob_cat, prob_wat)


    elseif length(il) == 9

      solute  = "protein"
      atoms   = PDBTools.readPDB(file)
      
      #protein selection
      sel0    = PDBTools.select(atoms,solute)    
      protein = ResTime.Selection(sel0, nmols=1)  # Selection for the calculation of time-correlation function / nmols = 1 (one protein)
      
      # components of the system
      cat = il[1:3]     
      an1 = il[5:6]

      if il[7:9] == "DCA"    
        an2 = "name N3A"     
      elseif il[7:9] == "BF4"
        an2 = "name B"
      elseif il[7:9] == "NO3"
        an2 = "name N and resname NO3"     
      end 

        
      # anion selection
      sel1    = PDBTools.select(atoms,"name $an1")
      anion1   = ResTime.Selection(sel1,natomspermol=1)     
     
      # anion selection
      sel2    = PDBTools.select(atoms,an2)
      anion2   = ResTime.Selection(sel2,natomspermol=1)  

      # cation selection
      sel3    = PDBTools.select(atoms,"name LP and resname $cat")
      cation  = ResTime.Selection(sel3,natomspermol=1)     
      
      # water selection
      sel4    = PDBTools.select(atoms,"name OW and resname SOL")
      water   = ResTime.Selection(sel4,natomspermol=1)     
      
      cutoff = 3.5 # cutoff based on MDDFs
      
      # time-correlation calculation for anion1
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion1, format="XTC")
      time_an1, prob_an1 = ResTime.corr_bench(trajectory,cutoff)
     
      # time-correlation calculation for anion2
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion2, format="XTC")
      time_an2, prob_an2 = ResTime.corr_bench(trajectory,cutoff) 

      # time-correlation calculation for cation
      trajectory = ResTime.Trajectory("processed.xtc", protein, cation, format="XTC")
      time_cat, prob_cat = corr_bench(trajectory,cutoff)
      
      # time-correlation calculation for WATER
      trajectory = ResTime.Trajectory("processed.xtc", protein, water, format="XTC")
      time_wat, prob_wat = corr_bench(trajectory,cutoff)
      
      if time_an1 ≈ time_cat && time_an1 ≈  time_wat && time_cat ≈ time_wat && time_an2 ≈ time_an1
        println("esta tudo ok!")
      end
      
      # Print the result in a file
      ResTime.writefile(il, conc, time_an1, prob_an1, prob_an2, prob_cat, prob_wat)

    elseif length(il) == 7

      solute  = "protein"
      atoms   = PDBTools.readPDB(file)
      
      #protein selection
      sel0    = PDBTools.select(atoms,solute)    
      protein = ResTime.Selection(sel0, nmols=1)  # Selection for the calculation of time-correlation function / nmols = 1 (one protein)
      
      # components of the system
      cat = il[1:3]     
      if il[5:7] == "DCA"
        an1 = "name N3A"
      elseif il[5:7] == "BF4"
        an1 = "name B"
      elseif il[5:7] == "NO3"
        an1 = "name N and resname NO3"
      end     

      # anion selection
      sel1    = PDBTools.select(atoms, an1)
      anion1   = ResTime.Selection(sel1,natomspermol=1)     
     
      # cation selection
      sel2    = PDBTools.select(atoms,"name LP and resname $cat")
      cation  = ResTime.Selection(sel2,natomspermol=1)     
      
      # water selection
      sel3    = PDBTools.select(atoms,"name OW and resname SOL")
      water   = ResTime.Selection(sel3,natomspermol=1)     
      
      cutoff = 3.5 # cutoff based on MDDFs
      
      # time-correlation calculation for anion1
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion1, format="XTC")
      time_an1, prob_an1 = ResTime.corr_bench(trajectory,cutoff)
        
      # time-correlation calculation for cation
      trajectory = ResTime.Trajectory("processed.xtc", protein, cation, format="XTC")
      time_cat, prob_cat = corr_bench(trajectory,cutoff)
      
      # time-correlation calculation for WATER
      trajectory = ResTime.Trajectory("processed.xtc", protein, water, format="XTC")
      time_wat, prob_wat = corr_bench(trajectory,cutoff)
      
      if time_an1 ≈ time_cat && time_an1 ≈  time_wat && time_cat ≈ time_wat 
        println("esta tudo ok!")
      end
      
      # Print the result in a file
      ResTime.writefile(il, conc, time_an1, prob_an1, prob_cat, prob_wat)

    elseif length(il) == 6

      solute  = "protein"
      atoms   = PDBTools.readPDB(file)
      
      #protein selection
      sel0    = PDBTools.select(atoms,solute)    
      protein = ResTime.Selection(sel0, nmols=1)  # Selection for the calculation of time-correlation function / nmols = 1 (one protein)
      
      # components of the system
      cat = il[1:3]     
      an1 = il[5:6]   
         
      # anion selection
      sel1    = PDBTools.select(atoms,"name $an1")
      anion1   = ResTime.Selection(sel1,natomspermol=1)     
     
      # cation selection
      sel2    = PDBTools.select(atoms,"name LP and resname $cat")
      cation  = ResTime.Selection(sel2,natomspermol=1)     
      
      # water selection
      sel3    = PDBTools.select(atoms,"name OW and resname SOL")
      water   = ResTime.Selection(sel3,natomspermol=1)     
      
      cutoff = 3.5 # cutoff based on MDDFs
      
      # time-correlation calculation for anion1
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion1, format="XTC")
      time_an1, prob_an1 = ResTime.corr_bench(trajectory,cutoff)
        
      # time-correlation calculation for cation
      trajectory = ResTime.Trajectory("processed.xtc", protein, cation, format="XTC")
      time_cat, prob_cat = corr_bench(trajectory,cutoff)
      
      # time-correlation calculation for WATER
      trajectory = ResTime.Trajectory("processed.xtc", protein, water, format="XTC")
      time_wat, prob_wat = corr_bench(trajectory,cutoff)
      
      if time_an1 ≈ time_cat && time_an1 ≈  time_wat && time_cat ≈ time_wat 
        println("esta tudo ok!")
      end
      
      # Print the result in a file
      ResTime.writefile(il, conc, time_an1, prob_an1, prob_cat, prob_wat)
       
    end

  end  





##### function 2 for tests
  export restime_calculation2 
  function restime_calculation2(il::String, main_dir::String, conc::String, file::String, cutoff)
    
    cd("$main_dir")
     
    if length(il) == 10   
       
      solute  = "protein"
      atoms   = PDBTools.readPDB(file)
      
      #protein selection
      sel0    = PDBTools.select(atoms,solute)    
      protein = ResTime.Selection(sel0, nmols=1)  # Selection for the calculation of time-correlation function / nmols = 1 (one protein)
   
      #println("passou da seleção do soluto")
      # components of the system
      cat = il[1:3]

      if il[5:7] == "DCA"
        an1 = "name N3A"
      elseif il[5:7] == "BF4"
        an1 = "name B"
      elseif il[5:7] == "NO3"
        an1 = "name N and resname NO3"
      end 
      

      

      if il[8:10] == "DCA"    
        an2 = "name N3A"     
      elseif il[8:10] == "BF4"
        an2 = "name B"
      elseif il[8:10] == "NO3"
        an2 = "name N and resname NO3"     
      end 
               


      # anion selection
      sel1     = PDBTools.select(atoms, an1)
      anion1   = ResTime.Selection(sel1,natomspermol=1)     
      #println("passou da seleção do ânion1 ")

      # anion selection
      sel2    = PDBTools.select(atoms, an2)
      anion2   = ResTime.Selection(sel2,natomspermol=1)  
      #println("passou da seleção do ânion2 ")

      # cation selection
      sel3    = PDBTools.select(atoms,"name LP and resname $cat")
      cation  = ResTime.Selection(sel3,natomspermol=1)     
      #println("passou da seleção do cation ")


      # water selection
      sel4    = PDBTools.select(atoms,"name OW and resname SOL")
      water   = ResTime.Selection(sel4,natomspermol=1)     
      
      cutoff = 3.5 # cutoff based on MDDFs
      
      # time-correlation calculation for anion1
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion1, format="XTC")
      time_an1, prob_an1 = ResTime.correlation(trajectory,cutoff)
      #println("passou da traj anion 1 ")    


      # time-correlation calculation for anion2
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion2, format="XTC")
      time_an2, prob_an2 = ResTime.correlation(trajectory,cutoff) 

      #println("passou da traj anion 2 ")


      # time-correlation calculation for cation
      trajectory = ResTime.Trajectory("processed.xtc", protein, cation, format="XTC")
      time_cat, prob_cat = ResTime.correlation(trajectory,cutoff)
      
      # time-correlation calculation for WATER
      trajectory = ResTime.Trajectory("processed.xtc", protein, water, format="XTC")
      time_wat, prob_wat = correlation(trajectory,cutoff)
     
      #println("passou da traj cation ")


      if time_an1 ≈ time_cat && time_an1 ≈  time_wat && time_cat ≈ time_wat && time_an2 ≈ time_an1
        println("esta tudo ok!")
      end
      
      # Print the result in a file
      ResTime.writefile(il, conc, time_an1, prob_an1, prob_an2, prob_cat, prob_wat)


    elseif length(il) == 9

      solute  = "protein"
      atoms   = PDBTools.readPDB(file)
      
      #protein selection
      sel0    = PDBTools.select(atoms,solute)    
      protein = ResTime.Selection(sel0, nmols=1)  # Selection for the calculation of time-correlation function / nmols = 1 (one protein)
      
      # components of the system
      cat = il[1:3]     
      an1 = il[5:6]

      if il[7:9] == "DCA"    
        an2 = "name N3A"     
      elseif il[7:9] == "BF4"
        an2 = "name B"
      elseif il[7:9] == "NO3"
        an2 = "name N and resname NO3"     
      end 

        
      # anion selection
      sel1    = PDBTools.select(atoms,"name $an1")
      anion1   = ResTime.Selection(sel1,natomspermol=1)     
     
      # anion selection
      sel2    = PDBTools.select(atoms,an2)
      anion2   = ResTime.Selection(sel2,natomspermol=1)  

      # cation selection
      sel3    = PDBTools.select(atoms,"name LP and resname $cat")
      cation  = ResTime.Selection(sel3,natomspermol=1)     
      
      # water selection
      sel4    = PDBTools.select(atoms,"name OW and resname SOL")
      water   = ResTime.Selection(sel4,natomspermol=1)     
      
      ##cutoff = 3.5 # cutoff based on MDDFs
      
      # time-correlation calculation for anion1
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion1, format="XTC")
      time_an1, prob_an1 = ResTime.correlation(trajectory,cutoff)
     
      # time-correlation calculation for anion2
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion2, format="XTC")
      time_an2, prob_an2 = ResTime.correlation(trajectory,cutoff) 

      # time-correlation calculation for cation
      trajectory = ResTime.Trajectory("processed.xtc", protein, cation, format="XTC")
      time_cat, prob_cat = correlation(trajectory,cutoff)
      
      # time-correlation calculation for WATER
      trajectory = ResTime.Trajectory("processed.xtc", protein, water, format="XTC")
      time_wat, prob_wat = correlation(trajectory,cutoff)
      
      if time_an1 ≈ time_cat && time_an1 ≈  time_wat && time_cat ≈ time_wat && time_an2 ≈ time_an1
        println("esta tudo ok!")
      end
      
      # Print the result in a file
      ResTime.writefile(il, conc, time_an1, prob_an1, prob_an2, prob_cat, prob_wat)

    elseif length(il) == 7

      solute  = "protein"
      atoms   = PDBTools.readPDB(file)
      
      #protein selection
      sel0    = PDBTools.select(atoms,solute)    
      protein = ResTime.Selection(sel0, nmols=1)  # Selection for the calculation of time-correlation function / nmols = 1 (one protein)
      
      # components of the system
      cat = il[1:3]     
      if il[5:7] == "DCA"
        an1 = "name N3A"
      elseif il[5:7] == "BF4"
        an1 = "name B"
      elseif il[5:7] == "NO3"
        an1 = "name N and resname NO3"
      end     

      # anion selection
      sel1    = PDBTools.select(atoms, an1)
      anion1   = ResTime.Selection(sel1,natomspermol=1)     
     
      # cation selection
      sel2    = PDBTools.select(atoms,"name LP and resname $cat")
      cation  = ResTime.Selection(sel2,natomspermol=1)     
      
      # water selection
      sel3    = PDBTools.select(atoms,"name OW and resname SOL")
      water   = ResTime.Selection(sel3,natomspermol=1)     
      
      ##cutoff = 3.5 # cutoff based on MDDFs
      
      # time-correlation calculation for anion1
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion1, format="XTC")
      time_an1, prob_an1 = ResTime.correlation(trajectory,cutoff)
        
      # time-correlation calculation for cation
      trajectory = ResTime.Trajectory("processed.xtc", protein, cation, format="XTC")
      time_cat, prob_cat = correlation(trajectory,cutoff)
      
      # time-correlation calculation for WATER
      trajectory = ResTime.Trajectory("processed.xtc", protein, water, format="XTC")
      time_wat, prob_wat = correlation(trajectory,cutoff)
      
      if time_an1 ≈ time_cat && time_an1 ≈  time_wat && time_cat ≈ time_wat 
        println("esta tudo ok!")
      end
      
      # Print the result in a file
      ResTime.writefile(il, conc, time_an1, prob_an1, prob_cat, prob_wat)

    elseif length(il) == 6

      solute  = "protein"
      atoms   = PDBTools.readPDB(file)
      
      #protein selection
      sel0    = PDBTools.select(atoms,solute)    
      protein = ResTime.Selection(sel0, nmols=1)  # Selection for the calculation of time-correlation function / nmols = 1 (one protein)
      
      # components of the system
      cat = il[1:3]     
      an1 = il[5:6]   
         
      # anion selection
      sel1    = PDBTools.select(atoms,"name $an1")
      anion1   = ResTime.Selection(sel1,natomspermol=1)     
     
      # cation selection
      sel2    = PDBTools.select(atoms,"name LP and resname $cat")
      cation  = ResTime.Selection(sel2,natomspermol=1)     
      
      # water selection
      sel3    = PDBTools.select(atoms,"name OW and resname SOL")
      water   = ResTime.Selection(sel3,natomspermol=1)     
      
      ##cutoff = 3.5 # cutoff based on MDDFs
      
      # time-correlation calculation for anion1
      trajectory = ResTime.Trajectory("processed.xtc", protein, anion1, format="XTC")
      time_an1, prob_an1 = ResTime.correlation(trajectory,cutoff)
        
      # time-correlation calculation for cation
      trajectory = ResTime.Trajectory("processed.xtc", protein, cation, format="XTC")
      time_cat, prob_cat = correlation(trajectory,cutoff)
      
      # time-correlation calculation for WATER
      trajectory = ResTime.Trajectory("processed.xtc", protein, water, format="XTC")
      time_wat, prob_wat = correlation(trajectory,cutoff)
      
      if time_an1 ≈ time_cat && time_an1 ≈  time_wat && time_cat ≈ time_wat 
        println("esta tudo ok!")
      end
      
      # Print the result in a file
      ResTime.writefile(il, conc, time_an1, prob_an1, prob_cat, prob_wat)
       
    end

  end  

