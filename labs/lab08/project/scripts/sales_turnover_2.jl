using DifferentialEquations, Plots


a1 = 0.061
a2 = 0.41
b = 0.0056
c2 = 0.84


function system!(dM, M, p, t)
    a1, a2, b, c2 = p
    dM[1] = M[1] - a1 * M[1]^2 - b * M[1] * M[2]
    dM[2] = c2 * M[2] - a2 * M[2]^2 - b * M[1] * M[2]
end


M0 = [3.3, 2.3]
θspan = (0.0, 50.0)


prob = ODEProblem(system!, M0, θspan, [a1, a2, b, c2])
sol = solve(prob, Tsit5(), saveat=0.1)


plot(sol,
     labels=["Фирма 1" "Фирма 2"],
     line=(:solid, 2),
     title="Динамика оборотных средств (базовый случай)",
     xlabel="Время θ",
     ylabel="Оборотные средства (млн руб.)",
     legend=:topright,
     dpi=300)


println("=== Базовый случай ===")
println("Начальные оборотные средства: ", M0)
println("Окончательные оборотные средства: ", sol.u[end])
println("Время симуляции: ", θspan[1], " → ", θspan[2])
println("Использованные коэффициенты: a1=$a1, a2=$a2, b=$b, c2=$c2")


savefig("case1_basic.png")
println("\nГрафик сохранён как 'case1_basic.png'")







