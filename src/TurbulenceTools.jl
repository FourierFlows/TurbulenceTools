__precompile__()

"""
Module structure:

  TurbulenceTools
    ... general utilities

    TwoDTurbTools
      ... twodturb utilities

    VerticallyCosineBoussinesqTools
    ...

"""
module TurbulenceTools
using FourierFlows, PyPlot

export makesquare!, ticksoff!, removespines!, getbasicoutput

# Stuff to help with plotting
makesquare!(ax) = ax[:set_aspect](1, adjustable="box")
makesquare!(axs::AbstractArray) = for ax in axs; makesquare!(ax); end

ticksoff!(a) = a[:tick_params](bottom=false, left=false, labelbottom=false, 
  labelleft=false)
ticksoff!(axs::AbstractArray) = for ax in axs; ticksoff!(ax); end

function removespines!(a)
  for spine in ["top", "bottom", "left", "right"]
    a[:spines][spine][:set_visible](false)
  end
  nothing
end

removespines!(axs::AbstractArray) = for ax in axs; removespines!(ax); end

"""
    getbasicoutput(prob, filename="default")

Returns Output whose only field is the solution.
"""
function getbasicoutput(prob; filename="default")
  getsol(prob) = prob.state.sol
  Output(prob, filename, (:sol, getsol))
end

include("twodturbtools.jl")
include("verticallycosinetools.jl")

end # module
