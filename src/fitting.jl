# fazer uma funçào para fitar

##EasyFit
#function adjust(il::String, c)
#    file1 = readdlm("DATA_TIMECORR_4A/timecorr-$il-$c-ions.dat", comments=true, comment_char='#')
#    # time for each concentration
#    time1 = file1[1:500, 1]
#    # data for each system compoent
#    if length(il) != 10
#      data1 = file1[1:500, 2] # anion
#      data2 = file1[1:500, 3] # cation
#    else
#      data1 = file1[1:500, 2]  # anion 1
#      data2 = file1[1:500, 3]  # anion 2
#      data3 = file1[1:500, 4]  # cation
#    end
#
#    if length(il) != 10
#      println("Exponetials fits")
#      println("*************************************")
#      println("$il")
#      println("       ")
#      println("Cation : $(il[1:4])")
#      fit2 = fitexp(time1, data2, n=3)
#      println(fit2)
#      println("  ")
#      println("Anion  : $(il[5:7])")
#      fit1 = fitexp(time1, data1, n=3)
#      println(fit1)
#      println("*************************************")
#    end 
#  end
#end
#
#
#
#
#
#
#
#
##using Polynomials
##using LsqFit
##using Plots
#
#```
#Function to perform a biexponential fit
#
#```
#function fitting(xdata, ydata)
#  p0 = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5]   # guess points - 
#  model(t, p) = p[1] * exp.(-p[2] * t) +  p[3] * exp.(-p[4] * t)  + p[5] * exp.(-p[6] * t)  # model trying to fit
#  nlin_fit(model, xdata, ydata, p0)
#end
#
#function fitting_md2(xdata, ydata)
#  p0 = [0.5, 0.5, 0.5]   # guess points - 
#  model(t, p) = (1 - p[1]) * exp(-p[2] * t) + p[1] * exp(-p[3] * t) 
#  nlin_fit(model, xdata, ydata, p0)
#end
#
#function nlin_fit(model, xdata, ydata, p0)
#
#  nlinfit = curve_fit(model, xdata, ydata, p0)
#  pfit = nlinfit.param
#  println(pfit)
#  xlin = range(xdata[1], xdata[end], length=200)
#
##  scatter(xdata, ydata, markersize=3, legend=:topright, label="data")
##  plot!(xlin, model(xlin, [p0[1], p0[2], p0[3], p0[4]]), label="initial model")
##  plot!(xlin, model(xlin, [pfit[1], pfit[2], pfit[3], pfit[4]]), linestyle=:dash, label="fitted model", dpi=200)
##
##  xaxis!("x")
##  yaxis!("y")
##  title!("nonlinear fit")
##
##  savefig("fitting_example.png")
#
#end
#
#
