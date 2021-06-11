
  using ResTime, PDBTools


function 


  # solute (protein) selection
  atoms   = PDBTools.readPDB("simul.pdb")
  protein = PDBTools.select(atoms,"protein")
  solute  = ResTime.Selection(protein,nmols=1)




  # dca autocorrelation calc
  if il=="EMIMDCA"
    dca            = PDBTools.select(atoms,"name N3A") 
  elseif il=="EMIMBF4"
    dca            = PDBTools.select(atoms,"name B") 
  end

  solvent        = ComplexMixtures.Selection(dca,natomspermol=1)
  trajectory     = ComplexMixtures.Trajectory("processed.xtc",solute,solvent,format="XTC")
  time, prob_an, dist, domain, evals, sp  = correlation(trajectory, 4.)  # 20 A = protein domain

  trajectory     = ComplexMixtures.Trajectory("processed.xtc",solute,solvent,format="XTC")
  time, prob_an2, dist2, domain2, evals2, sp2  = correlation(trajectory, 10.)  # 20 A = protein domain

  trajectory     = ComplexMixtures.Trajectory("processed.xtc",solute,solvent,format="XTC")
  time, prob_an3, dist3, domain3, evals3, sp3  = correlation(trajectory, 20.)  # 20 A = protein domain


  
  # emim autocorrelation calc
  emim           = PDBTools.select(atoms,"name LP") 
  solvent        = ComplexMixtures.Selection(emim,natomspermol=1)
  trajectory     = ComplexMixtures.Trajectory("processed.xtc",solute,solvent,format="XTC")
  time, prob_cat = correlation(trajectory,3.)  # 20 A = protein domain
      
  # water autocorrelation calc
  water           = PDBTools.select(atoms,"name OW") 
  solvent        = ComplexMixtures.Selection(water,natomspermol=1)
  trajectory     = ComplexMixtures.Trajectory("processed.xtc",solute,solvent,format="XTC")
  time, prob_wat = correlation(trajectory,3.)  # 20 A = protein domain
