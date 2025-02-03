
using Plots, LinearAlgebra


ATT = [10; 10; 10; 10; 10.38; 10.45; 10.45; 14.74;14.84;14.92;18.86;19.04;19.18;26.56;26.84;26.85;30.83;31.64;34.95;36.47;36.55;39.95;40.16;40.64]

BTT = [0;0;0;0;0;0;0;0.01620;0.02519;0.01185;0.06647;0.06231;0.06064;0.09988;0.10839;0.11975;0.15846;0.13521;0.19529;0.12323;0.15947;0;0;0]


mTT = size(ATT,1)
nTT = 8

scatter(ATT,BTT,label="Valor exato")

AsTT_5 = Float64[]

for i = 0:2nTT
    for k = 1:mTT
        local a = ATT[k]^(i)
        push!(AsTT_5,a)
    end    
end

SATT_5 = Float64[]

for i = 0:2nTT
    local s = 0
    for k = 1:mTT
        s = s + AsTT_5[i*mTT + k]
    end    
    push!(SATT_5,s)
end

SABTT_5 = Float64[]

for i = 0:nTT
    local s = 0
    for k = 1:mTT
        s = s + AsTT_5[i*mTT + k]*BTT[k]
    end    
    push!(SABTT_5,s)
end

STT_5 = zeros(nTT+1,nTT+1)

for i = 0:nTT
    for k = 0:nTT
        STT_5[i+1,k+1] = SATT_5[i+k+1]
    end
end

qrSTT_5 = qr(STT_5);

ETT = qrSTT_5\SABTT_5;


nTT = 6

AsTT_3 = Float64[]

for i = 0:2nTT
    for k = 1:mTT
        local a = ATT[k]^(i)
        push!(AsTT_3,a)
    end    
end

SATT_3 = Float64[]

for i = 0:2nTT
    local s = 0
    for k = 1:mTT
        s = s + AsTT_3[i*mTT + k]
    end    
    push!(SATT_3,s)
end

SABTT_3 = Float64[]

for i = 0:nTT
    local s = 0
    for k = 1:mTT
        s = s + AsTT_3[i*mTT + k]*BTT[k]
    end    
    push!(SABTT_3,s)
end

STT_3 = zeros(nTT+1,nTT+1)

for i = 0:nTT
    for k = 0:nTT
        STT_3[i+1,k+1] = SATT_3[i+k+1]
    end
end

qrSTT_3 = qr(STT_3);

ETT_3 = qrSTT_3\SABTT_3;

h_TT(x) = ETT_3[1] + ETT_3[2]*x + ETT_3[3]*x^2 + ETT_3[4]*x^3 + ETT_3[5]*x^4 + ETT_3[6]*x^5+ ETT_3[7]*x^6;
plot!(h_TT, label="Função do sexto grau")

nTT = 7

AsTT_4 = Float64[]

for i = 0:2nTT
    for k = 1:mTT
        local a = ATT[k]^(i)
        push!(AsTT_4,a)
    end    
end

SATT_4 = Float64[]

for i = 0:2nTT
    local s = 0
    for k = 1:mTT
        s = s + AsTT_4[i*mTT + k]
    end    
    push!(SATT_4,s)
end

SABTT_4 = Float64[]

for i = 0:nTT
    local s = 0
    for k = 1:mTT
        s = s + AsTT_4[i*mTT + k]*BTT[k]
    end    
    push!(SABTT_4,s)
end

STT_4 = zeros(nTT+1,nTT+1)

for i = 0:nTT
    for k = 0:nTT
        STT_4[i+1,k+1] = SATT_4[i+k+1]
    end
end

qrSTT_4 = qr(STT_4);

ETT_4 = qrSTT_4\SABTT_4;

g_TT(x) = ETT_4[1] + ETT_4[2]*x + ETT_4[3]*x^2 + ETT_4[4]*x^3 + ETT_4[5]*x^4+ETT_4[6]*x^5+ETT_4[7]*x^6+ETT_4[8]*x^7;
plot!(g_TT, label="Função do sétimo grau")

f_TT(x) = ETT[1] + ETT[2]*x + ETT[3]*x^2 + ETT[4]*x^3 + ETT[5]*x^4 + ETT[6]*x^5 + ETT[7]*x^6 + ETT[8]*x^7+ETT[9]*x^8;
plot!(f_TT, label="Função do oitavo grau")

savefig("nome_do_grafico.png")

