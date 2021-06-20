module ResTime
  using PDBTools 
  using FortranFiles
  using Printf
  using StructTypes
  using StaticArrays
  using CellListMap


  # ComplexMixtures files
  include("Selection.jl")
  include("FileOperations.jl")  
  include("viewmol.jl") 
  include("distance.jl")

  include("Trajectory.jl")
  include("ChemFiles.jl")
  include("NamdDCD.jl")
  include("PDBTraj.jl")
  ########################
 
  include("sample_space.jl")
  include("survivor_prob.jl")
  include("print_file.jl")
  include("events.jl")
  include("domain_eval.jl")
  include("correlation.jl")

  export autocorr 
  include("autocorr.jl")

  include("autocorr_CellList.jl")

end
