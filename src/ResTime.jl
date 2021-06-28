module ResTime
  using PDBTools 
  using FortranFiles
  using Printf
  using StructTypes
  using StaticArrays
  using CellListMap

  export distance 
  export correlation
  export correlation_cell
  export autocorr 
  export autocorr_cell


  include("Selection.jl")
  include("FileOperations.jl")  
  include("viewmol.jl") 
  include("distance.jl")

  include("Trajectory.jl")
  include("ChemFiles.jl")
  include("NamdDCD.jl")
  include("PDBTraj.jl")
 
  include("sample_space.jl")
  include("survivor_prob.jl")
  include("print_file.jl")
  include("events.jl")
  include("domain_eval.jl")
  include("correlation.jl")
  include("autocorr.jl")
  include("autocorr_CellList.jl")

end
