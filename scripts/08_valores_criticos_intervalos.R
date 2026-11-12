# Aproximar la varianza con 95% de confianza.

alfa = 0.05
s2 = var(muestra)
VC1 = qchisq(1 - alfa/2, df = n-1, lower.tail = F)
VC2 = qchisq(alfa/2, df = n-1, lower.tail = F)

intervalo = c(((n-1)*s2)/VC2, ((n-1)*s2)/VC1)
intervalo

## Con un 95% de confianza, la varianza se encuentra entre esos
## valores

# Intervalo con 95% de confianza conociendo sigma

desvpob = sqrt(varianzapob)
media = mean(muestra)
VCZ = qnorm(alfa/2, lower.tail = F)

intervalo = c(media - VCZ*desvpob/sqrt(n), media + VCZ*desvpob/sqrt(n))
intervalo

# Intervalo con 95% de confianza no conociendo sigma

desvmuestral = sd(muestra)
media = mean(muestra)
VCT= qt(alfa/2, df = n -1,lower.tail = F)

intervalo = c(media - VCT*desvmuestral/sqrt(n), media + VCT*desvmuestral/sqrt(n))
intervalo
