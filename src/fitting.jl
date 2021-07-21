# fazer uma funçào para fitar

using Polynomials
using LsqFit

using Plots

function main()

    # nonlinear fit stuff 
    p0 = [0.5, 0.5, 0.5, 0.5]                         # guess
    model(t, p) = p[1] * exp.(-p[2] * t) +  p[3] * exp.(-p[4] * t)   # model trying to fit

    xdata = range(0, stop=10, length=20)
    ydata = model(xdata, [1.0 2.0 1. 2.]) + 0.01*randn(length(xdata))

    nlin_fit(model, xdata, ydata, p0)

end

function nlin_fit(model, xdata, ydata, p0)

    nlinfit = curve_fit(model, xdata, ydata, p0)
    pfit = nlinfit.param
    print(pfit)
    xlin = range(xdata[1], xdata[end], length=200)

    scatter(xdata, ydata, markersize=3, legend=:topright, label="data")
    plot!(xlin, model(xlin, [p0[1], p0[2], p0[3], p0[4]]), label="initial model")
    plot!(xlin, model(xlin, [pfit[1], pfit[2], pfit[3], pfit[4]]), linestyle=:dash, label="fitted model", dpi=200)

    xaxis!("x")
    yaxis!("y")
    title!("nonlinear fit")

    savefig("fitting.png")

end


main()
