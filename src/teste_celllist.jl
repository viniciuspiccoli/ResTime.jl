  using ResTime,PDBTools
  dir="/home/viniciusp/Documents/doutorado/ANALYSE/Repository/restime_tests/Ionic_liquid"
  cd(dir)
  solute="protein"
  # solute (protein) selection
  atoms   = PDBTools.readPDB("simul.pdb")
  protein = PDBTools.select(atoms,solute)
  solute  = ResTime.Selection(protein,nmols=1) # next step, create a function to calculate these things for electrolyte solutions w/out proteins
  
  sel            = PDBTools.select(atoms,"name N and resname NO3")
  solvent        = ResTime.Selection(sel,natomspermol=1)
  trajectory     = ResTime.Trajectory("processed.xtc",solute,solvent,format="XTC")
   
  #time, prob = correlation_cell(trajectory,4.)
   dist, domain, evals, sp, nprot, nsvt, nframes, stime = autocorr_cell2(trajectory)

  # standard method 
  # trajectory     = ResTime.Trajectory("processed.xtc",solute,solvent,format="XTC")
  # dist2, domain2, evals2, sp2, nprot2, nsvt2, nframes2, stime2 = autocorr(trajectory)
  # ResTime.domain_eval!(dist2,domain2,4)
