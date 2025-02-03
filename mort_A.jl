
using Plots, LinearAlgebra


AMA = [10.54; 10.76; 15.30; 16.52; 20.05; 21.79; 25.64; 27.64; 31.33; 31.65; 32.55; 33.41]
BMA = [0.07585; 0.09169; 0.03608; 0.03266; 0.04216; 0.03718; 0.03043; 0.02709; 0.04391; 0.03417; 0.04438; 0.04983]


mMA = size(AMA,1)
nMA = 5

scatter(AMA,BMA, label ="Valor exato")

AsMA_5 = Float64[]

for i = 0:2nMA
    for k = 1:mMA
        local a = AMA[k]^(i)
        push!(AsMA_5,a)
    end    
end

SAMA_5 = Float64[]

for i = 0:2nMA
    local s = 0
    for k = 1:mMA
        s = s + AsMA_5[i*mMA + k]
    end    
    push!(SAMA_5,s)
end

SABMA_5 = Float64[]

for i = 0:nMA
    local s = 0
    for k = 1:mMA
        s = s + AsMA_5[i*mMA + k]*BMA[k]
    end    
    push!(SABMA_5,s)
end

SMA_5 = zeros(nMA+1,nMA+1)

for i = 0:nMA
    for k = 0:nMA
        SMA_5[i+1,k+1] = SAMA_5[i+k+1]
    end
end

qrSMA_5 = qr(SMA_5);

EMA = qrSMA_5\SABMA_5;



nMA = 3

AsMA_3 = Float64[]

for i = 0:2nMA
    for k = 1:mMA
        local a = AMA[k]^(i)
        push!(AsMA_3,a)
    end    
end

SAMA_3 = Float64[]

for i = 0:2nMA
    local s = 0
    for k = 1:mMA
        s = s + AsMA_3[i*mMA + k]
    end    
    push!(SAMA_3,s)
end

SABMA_3 = Float64[]

for i = 0:nMA
    local s = 0
    for k = 1:mMA
        s = s + AsMA_3[i*mMA + k]*BMA[k]
    end    
    push!(SABMA_3,s)
end

SMA_3 = zeros(nMA+1,nMA+1)

for i = 0:nMA
    for k = 0:nMA
        SMA_3[i+1,k+1] = SAMA_3[i+k+1]
    end
end

qrSMA_3 = qr(SMA_3);

EMA_3 = qrSMA_3\SABMA_3;

h_MA(x) = EMA_3[1] + EMA_3[2]*x + EMA_3[3]*x^2 + EMA_3[4]*x^3;
plot!(h_MA, label="Função do terceiro grau")

nMA = 4

AsMA_4 = Float64[]

for i = 0:2nMA
    for k = 1:mMA
        local a = AMA[k]^(i)
        push!(AsMA_4,a)
    end    
end

SAMA_4 = Float64[]

for i = 0:2nMA
    local s = 0
    for k = 1:mMA
        s = s + AsMA_4[i*mMA + k]
    end    
    push!(SAMA_4,s)
end

SABMA_4 = Float64[]

for i = 0:nMA
    local s = 0
    for k = 1:mMA
        s = s + AsMA_4[i*mMA + k]*BMA[k]
    end    
    push!(SABMA_4,s)
end

SMA_4 = zeros(nMA+1,nMA+1)

for i = 0:nMA
    for k = 0:nMA
        SMA_4[i+1,k+1] = SAMA_4[i+k+1]
    end
end

qrSMA_4 = qr(SMA_4);

EMA_4 = qrSMA_4\SABMA_4;

g_MA(x) = EMA_4[1] + EMA_4[2]*x + EMA_4[3]*x^2 + EMA_4[4]*x^3 + EMA_4[5]*x^4;
plot!(g_MA, label="Função do quarto grau")

f_MA(x) = EMA[1] + EMA[2]*x + EMA[3]*x^2 + EMA[4]*x^3 + EMA[5]*x^4 + EMA[6]*x^5;
plot!(f_MA, label="Função do quinto grau")
savefig("nome_do_grafico.png")