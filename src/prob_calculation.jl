export prob_calculation

function prob_calculation(pdb::String, cos_name::String, cos_selection::String, cutoff, trajectory; solute="protein", water=true, water_sel="name OW")

  # solute (protein) selection
  atoms   = PDBTools.readPDB(pdb)
  protein = PDBTools.select(atoms,solute)
  solute  = Selection(protein,nmols=1) # next step, create a function to calculate these things for electrolyte solutions w/out proteins
  
  # component of the cosolvent
  cosolvent      = PDBTools.select(atoms,cos_selection)
  solvent        = Selection(dca,natomspermol=1)
  trajectory     = Trajectory(trajectory,solute,solvent,format="XTC")
  time, prob_cos, dist, domain, evals, sp  = correlation(trajectory, cutoff) 
 
  if water==true
    water          = PDBTools.select(atoms,water_sel) 
    solvent        = Selection(water,natomspermol=1)
    trajectory     = Trajectory(trajectory,solute,solvent,format="XTC")
    time, prob_wat = correlation(trajectory, cutoff)  
  end
     
  #writting the file
  if water==true
    writefile(il,c,time, prob_cos, prob_wat)  
  else
    writefile(il,c,time, prob_cos)
  end
       
end 
