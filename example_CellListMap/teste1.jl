using CellListMap, StaticArrays, ResTime

# number of particles
N1= 50    # solute
N2= 350   # sovent

nframes = 50 # number of frames



Dist      = Array{Float64}(undef,nframes,N2) # matrix of final values

sides  = [350,350,350]  # no script de vdd isso muda
cutoff = 10.
box    = Box(sides,cutoff) # isso também muda


# Aqui eu preciso fazer um loop pelos frames de forma que ele pegue
# a menor distância de um átomo do solvente na proteína e salve
# na matrix na posição do frame e do solvente
# matriz de nframes linha por N2 colunas


# criar funcao que salva todas as distancias entre o átomo 1 do
#soluto com todos os átomos do solvente
# para cada frame eu vou ter uma matrix nsoluto x nsolvente
# ai eu faço a conta das menores distâncias e salvo na matrix dist
# que é nframes * nsolvente


function pair_dist!(x, y, i, j, sides, output)
  dims = x[i]
  pt   = y[j]


  #println(x[i],"    ",y[i])
  #println("  valor para a distância")


  d0 = ResTime.distance(dims, pt, sides)

  #println(d0)
    
  output[i,j]  = d0 

end


# function to find the minimum value saved in the matrix of atoms
function find_min!(M,dist,nframe)
  min = +Inf
  for i in 1:length(M[:,1])
    d = minimum(M[:,i])
    dist[nframe,i] = d
  end
end

teste = Array{Float64}(undef, N1, N2)

# loop principal

# claro que isso daqui vai dar qualquer porcaria, mas a ideia geral deve ser essa!

for h in 1:nframes

  # Particle positions
  x = [ box.sides .* rand(SVector{3,Float64}) for i in 1:N1 ]
  y = [ box.sides .* rand(SVector{3,Float64}) for i in 1:N2 ]
  
  # Initialize auxiliary linked lists (largest set!)
  cl = CellList(x,y,box)

  # atoms dist - must be allocated and calculated for each frame
  Mat = Array{Float64}(undef, N1, N2)

  map_pairwise!((x,y,i,j,d2,output) -> (x,y,i,j, sides, Mat), Mat,box,cl) 

  find_min!(Mat, Dist, h)

  teste = Mat

end



#println(Dist)



