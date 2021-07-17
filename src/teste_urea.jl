   using ResTime, PDBTools
   dir="/home/viniciusp/Documents/doutorado/ANALYSE/Repository/restime_tests/md-pulchra/urea/0.5/0"


 # dir="/home/viniciusp/Documents/doutorado/ANALYSE/Repository/restime_tests/Ionic_liquid"
  cd(dir)
  solute="protein"
  # solute (protein) selection
  atoms   = PDBTools.readPDB("processed.pdb")
  protein = PDBTools.select(atoms,solute)
  solute  = ResTime.Selection(protein,nmols=1) # next step, create a function to calculate these things for electrolyte solutions w/out proteins
  
#  sel            = PDBTools.select(atoms,"name C4 and resname UR")
  sel            = PDBTools.select(atoms,"name OW and resname SOL")
  solvent        = ResTime.Selection(sel,natomspermol=1)
  trajectory     = ResTime.Trajectory("processed.xtc",solute,solvent,format="XTC")
   
  time, prob = correlation_cell(trajectory,8.)
 # dist, domain, evals, sp, nprot, nsvt, nframes, stime = ]
 #autocorr_cell(trajectory)
 # ResTime.domain_eval_cell!(dist,domain,4.)

  # standard method 
   trajectory     = ResTime.Trajectory("processed.xtc",solute,solvent,format="XTC")
   time2, prob2 = correlation(trajectory,8.)

  # dist2, domain2, evals2, sp2, nprot2, nsvt2, nframes2, stime2 = autocorr(trajectory)
  # ResTime.domain_eval!(dist2,domain2,4.)



   using Plots
   plot(time, prob, label="CellList", color="red", linestyle=:dot)
   plot!(time2, prob2, label="Standard", color="blue", linewidth=2)   
   savefig("teste_water.png")

# AQUI TEM UM PROBLEMA COM AS MATRIZES DOMAIN


  if   prob ≈ prob2
    println("deu tudo certo no cálculo")
  else
    println("as probabilidades não estão iguais")
  end

