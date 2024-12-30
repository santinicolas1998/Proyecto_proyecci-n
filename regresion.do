clear all
set more off

import excel "C:\Users\User\Desktop\Santi\Trabajo CABA\Trabajo de predicción turismo receptivo CABA\Subido\datos_ficticios.xlsx", sheet("datos_f") cellrange(A1:C70) firstrow case(lower) clear

regress receptivo mes
predict yhat

// Crear observaciones adicionales para los próximos 74 meses
set obs 124
summarize mes, meanonly
local max_mes = r(max)
gen mes_extendido = mes
replace mes_extendido = _n + `max_mes' if mes_extendido == .
gen is_future = mes_extendido > `max_mes'


predict yhat_extendido, xb


	   
twoway (scatter receptivo mes, msymbol(circle) mcolor(blue)) ///
       (line yhat mes, lcolor(blue) lpattern(solid)) ///
       (line yhat_extendido mes_extendido if is_future == 1, lcolor(red) lpattern(dash)), ///
       title("Predicciones para los próximos 74 meses") ///
	   ylabel(, nogrid) ///
       legend(label(1 "Datos Reales") label(2 "Línea de Tendencia") label(3 "Predicciones Futuras"))


twoway (scatter receptivo mes, msymbol(circle) mcolor(blue)) ///
       (line yhat mes, lcolor(blue) lpattern(solid))
