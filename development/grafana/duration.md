# Duration

A continuación se muestra cómo extraer los diferentes componentes de una cadena de texto de tipo `duration`:
```shell
(
  $duration := "P1DT2H3M4S";
  $days := $substringBefore($substringAfter($duration, "P"), "D");
  $hours := $substringBefore($substringAfter($duration, "T"), "H");
  $minutes := $substringBefore($substringAfter($duration, "H"), "M");
  $seconds := $substringBefore($substringAfter($duration, "M"), "S");
  
  ($days = "" ? 0 : $number($days)) * 86400000 + 
  ($hours = "" ? 0 : $number($hours)) * 3600000 + 
  ($minutes = "" ? 0 : $number($minutes)) * 60000 + 
  ($seconds = "" ? 0 : $number($seconds)) * 1000
)
```