# ResTime

ResTime is a simple package to compute probability survival functions from molecular dynamics simulations (MD). These functions can be used to calculate the residence time of different solvent molecules in  MD trajectories. The general algorithm was based on the following two articles: [Link1](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1301175/) and [Link2](https://onlinelibrary.wiley.com/doi/abs/10.1002/jcc.540141116)

* [1 - Install](#install) 
* [2 - General explanation of the algorithm](#main_idea)
* [3 - Download of the trajectory for example 1](#download)

## <a name="install"></a>1. Install
The package can be installed using:
```
] add https://github.com/viniciuspiccoli/ResTime.jl
```

## <a name="main_idea"></a>2. General explanation of the algorithm


The algorithm used is based on well-established methods to calculate the residence time of water in different solvation layers of a protein (References given in Links 1 and 2). We calculate the probability that a molecule has to stay, throughout the simulation, within a distance R around the protein. In the calculations performed so far, the distance is defined by taking into account the MDDFs. For example, taking Figures 1 and 3 we have that the most prominent peaks for the ions appear up to 4Å. So, we will define a 4Å cut that will originate a perimeter around the solute (circular dotted line in schematic representation below) and, thus, we will evaluate, frame by frame, if a molecule is inside the perimeter or not. We create a matrix (that has the number of columns equal to the number of frames and the number of rows equal to the number of molecules) where if a molecule is within the perimeter we store 1, otherwise, we store zero. The Figure below shows a schematic representation of how the correlation functions were calculated.



<p align=center>
<img height=200px src= https://user-images.githubusercontent.com/42824876/126248112-a8a7edb9-07d5-4a5e-997d-2818da7e0790.png>
</p>	


Illustration of 4 frames from a molecular dynamics simulation. Each frame is separated by a fixed time equal to dt (time step of molecular dynamics). In the Figure, we are evaluating whether the water molecules are inside or outside the perimeter represented by the dashed lines. It is important to note that for complex solutes the dashed line, which indicates the cut-off point, will have varying shapes. This is because the distance we calculate is between one atom of the cosolvent (chosen for convenience, for example, the O of water) and the nearest atom of the protein.


In the example above, the molecule that is being observed (marked with ∗) is inside the perimeter (dotted circle) at time t, so we mark it 1. At time t + dt, the molecule is moving but is still inside the perimeter, so we also mark it 1. So we also mark it 1. However, in frames 3 (t + 2dt) and 4 (t + 3dt) the molecule is outside the perimeter, and so we mark it 0. We are left with a matrix of the form [1 1 0 0]. This matrix says that in frames 1 and 2 the molecule was inside the perimeter that we are analyzing.

The criterion for a molecule to be in the evaluated region is if it stays within the perimeter at time t and t + τ, where τ = ndt with n > 0. For 1 dt (1-time interval, we call it of dt1 ), there was once that the molecule stayed in the perimeter. For two, dt = 2 (dt 2 ), and three, dt = 3 (dt 3 ), time intervals after the first frame, there was no time that the water stayed inside the perimeter. Thus, we are generating a matrix that contains the number of times the molecule stayed in the perimeter given a value of dt. The correlation matrix becomes [1 0 0 ]. This matrix means that the molecule stayed inside the perimeter for a time equal to dt 1 and did not return.

Since we want to calculate the probability of survival, we need the sample space for the system. That is since we are dealing with 4 frames, the possibilities are to stay inside the evaluated region for three times the time dt1 , twice dt2, and once dt3 .

The sample space would be of the form [3 2 1 ]. Probability is the ratio between events (correlation matrix) and the sample space. Thus, P = [1/3 0/2 0/1]. So the above description shows how the probability functions (time-correlation functions) are being calculated. 




## <a name="download"></a>3. Download of the trajectory for example1
The data avaiable will be useful as an example for the way that ResTime.jl can be used to calculate time-correlation functions from molecular dynamics simulations

```

```

##     Example 1 

In this example, the time-correlation functions of EMIM, DCA, and water will be calculated until 3.5Å from the protein surface (vertical dotted line in the figure below). Minimum-distance distribution functions show that up to 3.5Å all relevant interactions with the protein already occurred, thus this distance will be used as a cutoff for the calculation.


<p align=center>
<img height=200px src= https://user-images.githubusercontent.com/42824876/126917146-53f14007-e568-4584-9bae-d627ef0862a6.png>
</p>	

------ completar as instruções

Loading the packages required for the calculations:
```
using ResTime, PDBTools, Plots, LaTeXStrings
```


To select the solute is necessary the usage of readPDB function from PDBTools, in this example, the solute is a protein. The first step is to load information about all atoms’ positions from a PDB (this PDB is the final frame of a simulation performed in gromacs).
```
solute  = "protein"
atoms   = PDBTools.readPDB("sample-groMD.pdb") # selection - all atoms of the PDB file.
```


After loading all atoms, it is necessary to select the protein atoms.
```
#protein selection
sel0    = PDBTools.select(atoms,solute)        # Selection of which atoms from the PDB are the protein atoms.
protein = ResTime.Selection(sel0, nmols=1)  # Selection for the calculation of time-correlation function / nmols = 1 (one protein)
```

Selection of solvent molecules. The calculation will use one atom for each solvent molecule. For instance, DCA is a molecule that contains 5 atoms (3 nitrogens and 2 carbons). For the time-corr calculation, it will be selected just the charged nitrogen. Therefore, performing the selection it is required the VMD nomenclature. Thus, to select the charged nitrogen of DCA the selection is `name N3A and resname NC`.
```
# anion selection
sel1    = PDBTools.select(atoms,"name N3A and resname NC")
anion   = ResTime.Selection(sel1,natomspermol=1)     # natomspermol = 1 - selection of 1 atom for each molecule

# cation selection
sel2    = PDBTools.select(atoms,"name LP and resname EMI")
cation  = ResTime.Selection(sel2,natomspermol=1)     # natomspermol = 1 - selection of 1 atom for each molecule
```
The oxygen selection from OPLS-AA TIP3P water can be done by:
```
# water selection
sel3    = PDBTools.select(atoms,"name OW and resname SOL")
water   = ResTime.Selection(sel3,natomspermol=1)     # natomspermol = 1 - selection of 1 atom for each molecule
```


Cutoff selection based on dotted line displayed at the MDDFs figure.
```
cutoff = 3.5 # cutoff based on MDDFs
```


Print file to save data:
```
# Print the result in a file
ResTime.writefile("EMIMDCA","1.50",time_an, prob_an, prob_cat, prob_wat)
```


Example of the final result.
<p align=center>
<img height=200px src=https://user-images.githubusercontent.com/42824876/127359481-062c62e5-ba64-4e91-9774-0defe495a981.png>
</p>







