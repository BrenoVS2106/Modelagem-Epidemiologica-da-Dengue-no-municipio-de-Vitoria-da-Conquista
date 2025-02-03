using DifferentialEquations, Plots, SimpleDiffEq
gr()

#Half-life of Carbon-14 is 5,730 years.
C₁ = 0.0645385

#Setup
u₀ = 36.5
T_m = 16.5
tspan = (0.0, 10.0)

#Define the problem
radioactivedecay(u, p, t) = -C₁ * (u-T_m)

#Pass to solver
prob = ODEProblem(radioactivedecay, u₀, tspan)
sol = solve(prob, Alshina2(0.5), dt = 0.5)


solu(x) = T_m +(u₀-T_m)*exp(-C₁*x)

#Plot
x=[0,1,2,3,4,5,6,7,8,9,10]

plot(x,solu, lw = 3, label = "Solução analitita")

plot!(sol, lw = 2, title = "Resfriamento de um corpo",
    xaxis = "Tempo", yaxis = "Temperatura",
    label = "Solução númerica")


