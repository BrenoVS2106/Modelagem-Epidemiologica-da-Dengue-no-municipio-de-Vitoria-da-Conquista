using LinearAlgebra, Plots, Printf, DifferentialEquations, SimpleDiffEq
include("mort_A.jl");
include("mort_AQ.jl");
include("ovoposicao.jl");
include("taxa_transicao.jl");
include("temp.jl");


N_h = 370879;                        # população humana
N_m = N_h;                           # população de mosquitos
μ_h = 0.007;                         # taxa de mortalidade natural para humanos
η_h = 0.994;                         # taxa de recuperação de humanos
β_hm = 0.013;                        # probabilidade de transmissão de I_h para mosquitos 
β_mh = 0.01;                         # probabilidade de transmissão de I_m para humanos
Β = 0.76;                            # media de mordidas do mosquito  
k = 2.02;                            # numero de larvas por humano 
m = 1.01;                            # numero de mosquitos femeas por humano

function ovo(i)
    a = trunc(Int,i)
    return (f_O(Media_tem[a+1]))
end

function MorteA(i)
    a = trunc(Int,i)
    return (f_MAQ(Media_tem[a+1]))
end

function MorteM(i)
    a = trunc(Int,i)
    return (f_MA(Media_tem[a+1]))

end

function taxatrans(i)
    a = trunc(Int,i)
    return (f_TT(Media_tem[a+1]))
end

ϕ = ovo(0)
println(ϕ)

function Problem!(du,u,p,t)
    ϕ = ovo(t)
    μ_A = MorteA(t)
    μ_m = MorteM(t)    
    η_A = taxatrans(t)
    du[1] = μ_h*N_h-(Β*β_mh*( u[6] /N_h) + μ_h)*u[1]
    du[2] = Β*β_mh*(u[6]/N_h)*u[1] - (η_h + μ_h)*u[2]
    du[3] = η_h * u[2]
    du[4] = ϕ*(1-u[4]/(k*N_h))*(u[5] + u[6]) - (η_A + μ_A)*u[4]
    du[5] = η_A*u[4] - (Β*β_hm*(u[2]/N_h) + μ_m)*u[5];
    du[6] = Β*β_hm*(u[2]/N_h)*u[5] - μ_m*u[6];
end

u0 = [370878; 500;0;N_h; 0;m*N_h]

tspan = (0.0,364.0)

prob = ODEProblem(Problem!, u0, tspan)
#alg = RK4()
sol = solve(prob,SimpleRK4(),dt=0.01)

V_x = Float64[]
R_0 = Float64[];

for i=0:364
    local ϕ = ovo(i)
    local μ_A = MorteA(i)
    local μ_m = MorteM(i)    
    local η_A = taxatrans(i)
    global Β, μ_h, k, β_hm, β_mh, η_h

    r_0 = sqrt((η_A*ϕ-(η_A+μ_A)*μ_m)*k*Β^2*β_hm*β_mh/((η_h+μ_h)*μ_m^2*ϕ))
    push!(R_0,r_0);
    push!(V_x,i+1)
end


plot(V_x,R_0,xlim=(0,365),ylim=(0,0.2), label= "R_0", xlabel = "Dias")


# plot(sol.t,log.(sol[1,:]), xlim=(0,365),  xlabel= "Dias", ylabel = "População humana (taxa em Log)", label="Populacao suscetivel", lw = 3, legend = :topright)
# plot!(sol.t,log.(sol[2,:]), label="Populacao infectada", lw = 3)
# plot!(sol.t,log.(sol[3,:]), label="Populacao recuperada", lw = 3)

# plot(sol.t,sol[1,:], xlim=(0,365),  xlabel= "Dias", ylabel = "População humana", label="Populacao suscetivel", lw = 3, legend = :topright)
# plot!(sol.t,sol[2,:], label="Populacao infectada", lw = 3)
# plot!(sol.t,sol[3,:], label="Populacao recuperada", lw = 3)

# plot(sol.t,log.(sol[4,:]), xlim=(0,365), xlabel= "Dias", ylabel = "População de mosquistos", label="Populacao de mosquistos na fase aquatica", lw = 3, legend = :bottomleft)
# plot!(sol.t,log.(sol[5,:]), label="Populacao de mosquistos suscetíveis", lw = 3)
# plot!(sol.t,log.(sol[6,:]), label="Populacao de mosquistos infectada ", lw = 3)

# plot(sol.t,log.(sol[1,:]))
# plot!(sol.t,log.(sol[2,:]))
# plot!(sol.t,log.(sol[3,:]))

# plot(log.(sol.t),log.(sol[1,:]))
# plot!(log.(sol.t),log.(sol[2,:]))
# plot!(log.(sol.t),log.(sol[3,:]))


