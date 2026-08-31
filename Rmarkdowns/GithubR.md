## Consejos para el Github

Un error muy común es que el commit no te deje realizarlo porque
"se está ejecutando algo"

en la terminal, ejecuta el siguiente código para cerrar procesos

```r
rm -f .git/index.lock
```