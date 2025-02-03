# Função que representa a EDO y' = f(t, y)

using Plots

k = 0.0645385;
T_m = 16.5; 

function f(t, y)
    # Exemplo: y' = y - t^2 + 1
    return -k*(y-T_m)
end

# Implementação do método de Runge-Kutta de segunda ordem
function runge_kutta_2nd_order(f, t0, y0, t_end, h)
    # t0: tempo inicial
    # y0: valor inicial de y no tempo t0
    # t_end: tempo final da simulação
    # h: tamanho do passo

    # Inicializando as variáveis
    t = t0
    y = y0
    
    # Criando arrays para armazenar os resultados
    time_values = [t]
    y_values = [y]
    
    # Loop de integração
    while t < t_end
        # Calculando os incrementos de acordo com RK2
        k1 = h * f(t, y)
        k2 = h * f(t + 0.5 * h, y + 0.5 * k1)
        
        # Atualizando o valor de y
        y += k2
        
        # Atualizando o valor de t
        t += h
        
        # Armazenando os valores calculados
        push!(time_values, t)
        push!(y_values, y)
    end
    
    return time_values, y_values
end

# Parâmetros iniciais
t0 = 0.0
y0 = 36.5
t_end = 1.0
h = 0.1

# Executando o método RK2
t_values, y_values = runge_kutta_2nd_order(f, t0, y0, t_end, h)

solu(x) = T_m +(y0-T_m)*exp(-k*x)
x=[0,1]


plot(x, solu, lw = 3, label = "Solução analitita")
plot!(t_values,y_values,lw = 3, label = "Solução obtida via Método de Euler")
