<!DOCTYPE html>
<html lang="ca-ES">
  <head>
    <meta charset="utf-8"/>
    <title>Tarot - dades</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <link rel="stylesheet" href="estils/estil.css">  -->
  </head>
  <body> 
	  <h1>Tarot - tirada de cartes</h1>
    <?php
		$tarotRiderWaite = ["0 - El Loco", "I - El Mago", "II - La Sacerdotisa", "III - La Emperatriz", "IV - El Emperador", "V - El Hierofante", "VI - Los Enamorados", "VII - El Carro", "VIII - La Justicia", "IX - El Ermitaño", "X - La Rueda de la Fortuna", "XI - La Fuerza", "XII - El Colgado", "XIII - La Muerte", "XIV - La Templanza", "XV - El Diablo", "XVI - La Torre", "XVII - La Estrella", "XVIII - La Luna", "XIX - El Sol", "XX - El Juicio", "XXI - El Mundo", "As de Varitas", "Dos de Varitas", "Tres de Varitas", "Cuatro de Varitas", "Cinco de Varitas", "Seis de Varitas", "Siete de Varitas", "Ocho de Varitas", "Nueve de Varitas", "Diez de Varitas", "Paje de Varitas", "Caballero de Varitas", "Reina de Varitas", "Rey de Varitas", "As de Copas", "Dos de Copas", "Tres de Copas", "Cuatro de Copas", "Cinco de Copas", "Seis de Copas", "Siete de Copas", "Ocho de Copas", "Nueve de Copas", "Diez de Copas", "Paje de Copas", "Caballero de Copas", "Reina de Copas", "Rey de Copas", "As de Espadas", "Dos de Espadas", "Tres de Espadas", "Cuatro de Espadas", "Cinco de Espadas", "Seis de Espadas", "Siete de Espadas", "Ocho de Espadas", "Nueve de Espadas", "Diez de Espadas", "Paje de Espadas", "Caballero de Espadas", "Reina de Espadas", "Rey de Espadas", "As de Oros", "Dos de Oros", "Tres de Oros", "Cuatro de Oros", "Cinco de Oros", "Seis de Oros", "Siete de Oros", "Ocho de Oros", "Nueve de Oros", "Diez de Oros", "Paje de Oros", "Caballero de Oros", "Reina de Oros", "Rey de Oros"];
		$dataStr = $_REQUEST["data-naixement"];
		echo "<p>La teva data de naixement és ".$_REQUEST["data-naixement"]."</p>";

		function obteCarta(string $dataStr, array $tarotRiderWaite): string {
			$any = substr($dataStr,0,4);
			$mes = substr($dataStr,5,2);
			$dia = substr($dataStr,8);
			
			$resultat = $dia + ($mes*100)+($any*1000);
			$numcartes = count($tarotRiderWaite);
			$residu = $resultat % $numcartes;
			
			return $tarotRiderWaite[$residu];
			
		}
		echo "La teva carta és: ".obteCarta($dataStr, $tarotRiderWaite)."";
    ?>
  </body>
</html>
