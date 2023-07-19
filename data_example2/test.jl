
import ResTime, PDBTools
using Plots

let 
    
    solute  = "protein"
    atoms   = PDBTools.readPDB("processed2.pdb")
    
    sel0    = PDBTools.select(atoms,solute)
    protein = ResTime.Selection(sel0, nmols=1)
    
    sel1    = PDBTools.select(atoms,"name Cl");
    anion   = ResTime.Selection(sel1,natomspermol=1)
    
    #aqui eu preciso checar qual o melhjor átomo do EMI para analisar
    sel2    = PDBTools.select(atoms,"name C01 and resname EMI");
    cation   = ResTime.Selection(sel2,natomspermol=1)
    
    sel3    = PDBTools.select(atoms,"name OW and resname SOL");
    water   = ResTime.Selection(sel3,natomspermol=1)
    
    i = 40 # cutoff cell list map 
   # for i in 10:5:15

        cutoff = 3.5
        plot(layout=(2,2))
        gr(dpi=600)
        plot!(subplot=1, title="Water")
        plot!(subplot=2, title="cation")
        plot!(subplot=3, title="Anion")
    
        #usando o emu programa
    
        trajectory = ResTime.Trajectory("processed2.xtc", protein, anion, format="XTC");
        time_an1, prob_an1, dist1 = ResTime.correlation(trajectory,cutoff); 
    
        trajectory = ResTime.Trajectory("processed2.xtc", protein, cation, format="XTC");
        time_an2, prob_an2, dist2 = ResTime.correlation(trajectory,cutoff);    
    
        trajectory = ResTime.Trajectory("processed2.xtc", protein, water, format="XTC");
        time_an3, prob_an3, dist3 = ResTime.correlation(trajectory,cutoff); 
    
        plot!(subplot=1, ls=:dash, time_an1, prob_an1, color="red", label=false)
        plot!(subplot=2, ls=:dash, time_an2, prob_an2, color="red", label=false)
        plot!(subplot=3, ls=:dash, time_an3, prob_an3, color="red", label=false)
    
        # usando o programa do leandro
    
        #trajectory = ResTime.Trajectory("processed2.xtc", protein, anion, format="XTC");
        #time_an, prob_an, dist = ResTime.correlation(trajectory,cutoff);
    
        trajectory = ResTime.Trajectory("processed2.xtc", protein, anion, format="XTC");
        time_an1, prob_an1, dist1 = ResTime.correlation_cell(trajectory,cutoff, cutoff_cl=i); 
    
        trajectory = ResTime.Trajectory("processed2.xtc", protein, cation, format="XTC");
        time_an2, prob_an2, dist2 = ResTime.correlation_cell(trajectory,cutoff, cutoff_cl=i);    
    
        trajectory = ResTime.Trajectory("processed2.xtc", protein, water, format="XTC");
        time_an3, prob_an3, dist3 = ResTime.correlation_cell(trajectory,cutoff, cutoff_cl=i); 
    
        plot!(subplot=1, time_an1, prob_an1, color="blue", label=false)
        plot!(subplot=2, time_an2, prob_an2, color="blue", label=false)
        plot!(subplot=3, time_an3, prob_an3, color="blue", label=false)
        savefig("cutoff_$(i).png")
        plot()
        
   # end

end
