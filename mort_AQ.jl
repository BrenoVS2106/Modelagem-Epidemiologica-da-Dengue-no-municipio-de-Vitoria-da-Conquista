
using Plots, LinearAlgebra


AMAQ = [10; 10; 10; 10; 10.38; 10.45; 10.45; 14.74;14.84;14.92;18.86;19.04;19.18;26.56;26.84;26.85;30.83;31.61;34.95;36.47;36.55;39.95;40.16;40.64]
BMAQ = [0.16173;0.09729;0.08170;0.22253;0.46886;0.17455;0.20706;0.02087;0.02344;0.01809;0.03672;0.02063;0.03310;0.06779;0.06311;0.06388;0.10498;0.05936;0.11567;0.07062;0.09993;0.31994;0.26644;0.28482]

mMAQ = size(AMAQ,1)
nMAQ = 5

scatter(AMAQ,BMAQ, label ="Valor exato")

AsMAQ_5 = Float64[]

for i = 0:2nMAQ
    for k = 1:mMAQ
        local a = AMAQ[k]^(i)
        push!(AsMAQ_5,a)
    end    
end

SAMAQ_5 = Float64[]

for i = 0:2nMAQ
    local s = 0
    for k = 1:mMAQ
        s = s + AsMAQ_5[i*mMAQ + k]
    end    
    push!(SAMAQ_5,s)
end

SABMAQ_5 = Float64[]

for i = 0:nMAQ
    local s = 0
    for k = 1:mMAQ
        s = s + AsMAQ_5[i*mMAQ + k]*BMAQ[k]
    end    
    push!(SABMAQ_5,s)
end

SMAQ_5 = zeros(nMAQ+1,nMAQ+1)

for i = 0:nMAQ
    for k = 0:nMAQ
        SMAQ_5[i+1,k+1] = SAMAQ_5[i+k+1]
    end
end

qrSMAQ_5 = qr(SMAQ_5);

EMAQ = qrSMAQ_5\SABMAQ_5;



nMAQ = 3

AsMAQ_3 = Float64[]

for i = 0:2nMAQ
    for k = 1:mMAQ
        local a = AMAQ[k]^(i)
        push!(AsMAQ_3,a)
    end    
end

SAMAQ_3 = Float64[]

for i = 0:2nMAQ
    local s = 0
    for k = 1:mMAQ
        s = s + AsMAQ_3[i*mMAQ + k]
    end    
    push!(SAMAQ_3,s)
end

SABMAQ_3 = Float64[]

for i = 0:nMAQ
    local s = 0
    for k = 1:mMAQ
        s = s + AsMAQ_3[i*mMAQ + k]*BMAQ[k]
    end    
    push!(SABMAQ_3,s)
end

SMAQ_3 = zeros(nMAQ+1,nMAQ+1)

for i = 0:nMAQ
    for k = 0:nMAQ
        SMAQ_3[i+1,k+1] = SAMAQ_3[i+k+1]
    end
end

qrSMAQ_3 = qr(SMAQ_3);

EMAQ_3 = qrSMAQ_3\SABMAQ_3;

h_MAQ(x) = EMAQ_3[1] + EMAQ_3[2]*x + EMAQ_3[3]*x^2 + EMAQ_3[4]*x^3;
plot!(h_MAQ, label="Função do terceiro grau")

nMAQ = 4

AsMAQ_4 = Float64[]

for i = 0:2nMAQ
    for k = 1:mMAQ
        local a = AMAQ[k]^(i)
        push!(AsMAQ_4,a)
    end    
end

SAMAQ_4 = Float64[]

for i = 0:2nMAQ
    local s = 0
    for k = 1:mMAQ
        s = s + AsMAQ_4[i*mMAQ + k]
    end    
    push!(SAMAQ_4,s)
end

SABMAQ_4 = Float64[]

for i = 0:nMAQ
    local s = 0
    for k = 1:mMAQ
        s = s + AsMAQ_4[i*mMAQ + k]*BMAQ[k]
    end    
    push!(SABMAQ_4,s)
end

SMAQ_4 = zeros(nMAQ+1,nMAQ+1)

for i = 0:nMAQ
    for k = 0:nMAQ
        SMAQ_4[i+1,k+1] = SAMAQ_4[i+k+1]
    end
end

qrSMAQ_4 = qr(SMAQ_4);

EMAQ_4 = qrSMAQ_4\SABMAQ_4;

g_MAQ(x) = EMAQ_4[1] + EMAQ_4[2]*x + EMAQ_4[3]*x^2 + EMAQ_4[4]*x^3 + EMAQ_4[5]*x^4;
plot!(g_MAQ, label="Função do quarto grau")
f_MAQ(x) = EMAQ[1] + EMAQ[2]*x + EMAQ[3]*x^2 + EMAQ[4]*x^3 + EMAQ[5]*x^4 + EMAQ[6]*x^5;
plot!(f_MAQ, label="Função do quinto grau")
savefig("nome_do_grafico.png")