# fazer uma funçào para fitar

#using Polynomials
#using LsqFit
#using Plots

```
Function to perform a biexponential fit

```
function fitting(xdata, ydata)

  p0 = [0.5, 0.5, 0.5, 0.5]   # guess points - 
  model(t, p) = p[1] * exp.(-p[2] * t) +  p[3] * exp.(-p[4] * t)   # model trying to fit
  nlin_fit(model, xdata, ydata, p0)

end

function fitting_md2(xdata, ydata)
  p0 = [0.5, 0.5, 0.5]   # guess points - 
  model(t, p) = (1 - p[1]) * exp(-p[2] * t) + p[1] * exp(-p[3] * t) 
  nlin_fit(model, xdata, ydata, p0)
end

function nlin_fit(model, xdata, ydata, p0)

  nlinfit = curve_fit(model, xdata, ydata, p0)
  pfit = nlinfit.param
  println(pfit)
  xlin = range(xdata[1], xdata[end], length=200)

#  scatter(xdata, ydata, markersize=3, legend=:topright, label="data")
#  plot!(xlin, model(xlin, [p0[1], p0[2], p0[3], p0[4]]), label="initial model")
#  plot!(xlin, model(xlin, [pfit[1], pfit[2], pfit[3], pfit[4]]), linestyle=:dash, label="fitted model", dpi=200)
#
#  xaxis!("x")
#  yaxis!("y")
#  title!("nonlinear fit")
#
#  savefig("fitting_example.png")

end


