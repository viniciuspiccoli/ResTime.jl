
import ResTime, PDBTools

solute  = "protein"

atoms   = PDBTools.readPDB("processed2.pdb")
sel0    = PDBTools.select(atoms,solute)

sel1    = PDBTools.select(atoms,"name Cl");

anion   = ResTime.Selection(sel1,natomspermol=1)

cutoff = 3.5
protein = ResTime.Selection(sel0, nmols=1)

#println("calculation using the slower method")
#trajectory = ResTime.Trajectory("processed.xtc", protein, anion, format="XTC");
#time_an, prob_an = ResTime.corr_bench(trajectory,cutoff)    

println("Calculation using the faster method")
trajectory = ResTime.Trajectory("processed2.xtc", protein, anion, format="XTC");
time_an, prob_an = ResTime.correlation(trajectory,cutoff)

