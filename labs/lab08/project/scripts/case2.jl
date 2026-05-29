using DifferentialEquations, Plots


a1 = 0.05
a2 = 0.39
b1 = 0.001
b2 = 0.01


function system!(dM, M, p, t)
    a1, a2, b1, b2 = p
    dM[1] = M[1] - a1 * M[1]^2 - b1 * M[1] * M[2]
    dM[2] = 0.9 * M[2] - a2 * M[2]^2 - b2 * M[1] * M[2]
end


M0 = [3.3, 2.3]
θspan = (0.0, 50.0)

prob = ODEProblem(system!, M0, θspan, [a1, a2, b1, b2])
sol = solve(prob, Tsit5(), saveat=0.1)

plot(sol,
     labels=["Фирма 1 (с брендом)" "Фирма 2 (с брендом)"],
     line=(:dash, 2),
     title="Динамика оборотных средств (случай с брендом)",
     xlabel="Время θ",
     ylabel="Оборотные средства (млн руб.)",
     legend=:topright,
     dpi=300)


println("=== Случай с брендом ===")
println("Начальные оборотные средства: ", M0)
println("Окончательные оборотные средства: ", sol.u[end])
println("Время симуляции: ", θspan[1], " → ", θspan[2])
println("Использованные коэффициенты: a1=$a1, a2=$a2, b1=$b1, b2=$b2")


savefig("case2_brand.png")
println("\nГрафик сохранён как 'case2_brand.png'")


