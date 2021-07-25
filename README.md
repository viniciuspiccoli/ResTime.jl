# ResTime

ResTime is a simple package to compute probability survival functions from molecular dynamics simulations (MD). These functions can be used to calculate the residence time of different solvent molecules in  MD trajectories. The general algorithm was based on the following two articles: [Link1](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1301175/) and [Link2](https://onlinelibrary.wiley.com/doi/abs/10.1002/jcc.540141116)


## Install
The package can be installed using:
```
] add https://github.com/viniciuspiccoli/ResTime.jl
```

## Main idea


The algorithm used is based on well-established methods to calculate the residence time of water in different solvation layers of a protein (References given in Links 1 and 2). We calculate the probability that a molecule has to stay, throughout the simulation, within a distance R around the protein. In the calculations performed so far, the distance is defined by taking into account the MDDFs. For example, taking Figures 1 and 3 we have that the most prominent peaks for the ions appear up to 4Å. So, we will define a 4Å cut that will originate a perimeter around the solute (circular dotted line in schematic representation below) and, thus, we will evaluate, frame by frame, if a molecule is inside the perimeter or not. We create a matrix (that has the number of columns equal to the number of frames and the number of rows equal to the number of molecules) where if a molecule is within the perimeter we store 1, otherwise, we store zero. The Figure below shows a schematic representation of how the correlation functions were calculated.



<p align=center>
<img height=200px src= https://user-images.githubusercontent.com/42824876/126248112-a8a7edb9-07d5-4a5e-997d-2818da7e0790.png>
</p>	


-- Adaptar isso daqui para ser uma legenda
Illustration of 4 frames from a molecular dynamics simulation. Each frame is separated by a fixed time equal to dt (time step of molecular dynamics). In the Figure, we are evaluating whether the water molecules are inside or outside the perimeter represented by the dashed lines. It is important to note that for complex solutes the dashed line, which indicates the cut-off point, will have varying shapes. This is because the distance we calculate is between one atom of the cosolvent (chosen for convenience, for example, the O of water) and the nearest atom of the protein.


In the example above, the molecule that is being observed (marked with ∗) is inside the perimeter (dotted circle) at time t, so we mark it 1. At time t + dt, the molecule is moving but is still inside the perimeter, so we also mark it 1. So we also mark it 1. However, in frames 3 (t + 2dt) and 4 (t + 3dt) the molecule is outside the perimeter, and so we mark it 0. We are left with a matrix of the form [1 1 0 0]. This matrix says that in frames 1 and 2 the molecule was inside the perimeter that we are analyzing.

The criterion for a molecule to be in the evaluated region is if it stays within the perimeter at time t and t + τ, where τ = ndt with n > 0. For 1 dt (1-time interval, we call it of dt1 ), there was once that the molecule stayed in the perimeter. For two, dt = 2 (dt 2 ), and three, dt = 3 (dt 3 ), time intervals after the first frame, there was no time that the water stayed inside the perimeter. Thus, we are generating a matrix that contains the number of times the molecule stayed in the perimeter given a value of dt. The correlation matrix becomes [1 0 0 ]. This matrix means that the molecule stayed inside the perimeter for a time equal to dt 1 and did not return.

Since we want to calculate the probability of survival, we need the sample space for the system. That is since we are dealing with 4 frames, the possibilities are to stay inside the evaluated region for three times the time dt1 , twice dt2, and once dt3 .

The sample space would be of the form [3 2 1 ]. Probability is the ratio between events (correlation matrix) and the sample space. Thus, P = [1/3 0/2 0/1]. So the above description shows how the probability functions are being calculated. 


## Example 1

![drawing](https://user-images.githubusercontent.com/42824876/126917146-53f14007-e568-4584-9bae-d627ef0862a6.png)


----- Figura ficou feia porque cortei a trajetória - Manter só para ajudar no texto
[time_corr_functions.pdf](https://github.com/viniciuspiccoli/ResTime.jl/files/6874720/time_corr_functions.pdf)




