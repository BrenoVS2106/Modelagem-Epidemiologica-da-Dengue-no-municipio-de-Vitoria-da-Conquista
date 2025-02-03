
using Plots, LinearAlgebra


AO = [10.54; 10.76; 15.30; 16.52; 20.05; 21.79; 25.64; 27.64; 31.33; 31.65; 32.55; 33.41]

BO = [0; 0; 0.3548; 1.1208; 3.3668; 3.5931; 6.9847; 7.5997; 9.5762; 7.2770; 11.224; 7.2745]


mO = size(AO,1)
nO = 5

scatter(AO,BO, label="Valor exato")

AsO_5 = Float64[]

for i = 0:2nO
    for k = 1:mO
        local a = AO[k]^(i)
        push!(AsO_5,a)
    end    
end

SAO_5 = Float64[]

for i = 0:2nO
    local s = 0
    for k = 1:mO
        s = s + AsO_5[i*mO + k]
    end    
    push!(SAO_5,s)
end

SABO_5 = Float64[]

for i = 0:nO
    local s = 0
    for k = 1:mO
        s = s + AsO_5[i*mO + k]*BO[k]
    end    
    push!(SABO_5,s)
end

SO_5 = zeros(nO+1,nO+1)

for i = 0:nO
    for k = 0:nO
        SO_5[i+1,k+1] = SAO_5[i+k+1]
    end
end

qrSO_5 = qr(SO_5);

EO = qrSO_5\SABO_5;



nO = 3

AsO_3 = Float64[]

for i = 0:2nO
    for k = 1:mO
        local a = AO[k]^(i)
        push!(AsO_3,a)
    end    
end

SAO_3 = Float64[]

for i = 0:2nO
    local s = 0
    for k = 1:mO
        s = s + AsO_3[i*mO + k]
    end    
    push!(SAO_3,s)
end

SABO_3 = Float64[]

for i = 0:nO
    local s = 0
    for k = 1:mO
        s = s + AsO_3[i*mO + k]*BO[k]
    end    
    push!(SABO_3,s)
end

SO_3 = zeros(nO+1,nO+1)

for i = 0:nO
    for k = 0:nO
        SO_3[i+1,k+1] = SAO_3[i+k+1]
    end
end

qrSO_3 = qr(SO_3);

EO_3 = qrSO_3\SABO_3;

h_O(x) = EO_3[1] + EO_3[2]*x + EO_3[3]*x^2 + EO_3[4]*x^3;
plot!(h_O, label="Função do terceiro grau")

nO = 4

AsO_4 = Float64[]

for i = 0:2nO
    for k = 1:mO
        local a = AO[k]^(i)
        push!(AsO_4,a)
    end    
end

SAO_4 = Float64[]

for i = 0:2nO
    local s = 0
    for k = 1:mO
        s = s + AsO_4[i*mO + k]
    end    
    push!(SAO_4,s)
end

SABO_4 = Float64[]

for i = 0:nO
    local s = 0
    for k = 1:mO
        s = s + AsO_4[i*mO + k]*BO[k]
    end    
    push!(SABO_4,s)
end

SO_4 = zeros(nO+1,nO+1)

for i = 0:nO
    for k = 0:nO
        SO_4[i+1,k+1] = SAO_4[i+k+1]
    end
end

qrSO_4 = qr(SO_4);

EO_4 = qrSO_4\SABO_4;

g_O(x) = EO_4[1] + EO_4[2]*x + EO_4[3]*x^2 + EO_4[4]*x^3 + EO_4[5]*x^4;
plot!(g_O, label="Função do quarto grau")

f_O(x) = EO[1] + EO[2]*x + EO[3]*x^2 + EO[4]*x^3 + EO[5]*x^4 + EO[6]*x^5;
plot!(f_O, label="Função do quinto grau")

savefig("nome_do_grafico.png")