<!DOCTYPE html>
<html lang="ca-ES">
  <head>
    <meta charset="utf-8"/>
    <title>Factura Jan Ribera</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/css.css"> <!-- atenció, cal crear-lo! -->
  </head>
  <body>
    <!--contingut -->
    <h1>Factura</h1>
    <?php
    echo "<table>";
    echo "<tr><td>Article</td><td>Quantitat</td><td>Preu/u</td><td>Subtotal</td><td>Descompte</td><td>Iva 21%</td><td>Total</td></tr>";

        //definim un array per a un ús futur de memoria
        $arraypergen = [];

        

        // array amb tota la llista de productess del
        // enunciat amb la seva respectiva informacio

        $productes = [
            ["patates", "images/patata.jpg","kg",2.05],
            ["ceba","images/ceba.jpg","kg",2.5],
            ["api","images/api.jpg","manat",3],
            ["oli granel","images/oli.jpg","l",8.5],
            ["pastilla sabó","images/sabo.jpg","unitat",4.99],
            ["lluc","images/lluc.jpg","kg",10.55],
            ["manat de pastanaga", "images/pastanaga_manat.jpg","manat",3.5]
        ];

        ////////////////////////////////
        //
        //        FUNCIONS
        //


        /**
         * Calcular l'IVA.
         * @param float $iva És l'IVA que aplicarem al producte. Si es deixa buit o a 0 es posarà automàticament al 21%
         * @param float $import És el import total abans d'aplicar el IVA
         *
         * @return float Retorna l'IVA calculat que s'aplicarà.
         */
        function calcularIVA($iva, float $import) {
            if ($iva == 0 || $iva == "" || $iva == NULL) {
                $iva = 1.21;
                $ivaaplicat = ($import * $iva)-$import;
            } else {
                $ivaaplicat = ($import * (($iva+100)/100)) - ($import);
            }
            return $ivaaplicat;
        }

        /**
         * Get Productes.
         * 
         * Aquesta funció retorna el nom d'un producte a partir d'un array de productes.
         * 
         * @param array $productes És l'array on s'emmagatzemen els productes.
         * @param int $i És l'índex on volem buscar, automàticament ho farà el bucle.
         *
         * @return string Retorna el nom del producte com a string.
         */
        function getproductes(array $arraypergen, int $i) {
            $nom = $arraypergen[$i][0];
            return $nom;
        }

        /**
         * Get Unitat.
         * 
         * Aquesta funció retorna la unitat d'un producte a partir d'un array de productes.
         * 
         * @param array $productes És l'array on s'emmagatzemen els productes.
         * @param int $i És l'índex on volem buscar, automàticament ho farà el bucle.
         *
         * @return string Retorna la unitat del producte com a string.
         */
        function getunitat(array $arraypergen, int $i) {
            $nom = $arraypergen[$i][2];
            return $nom;
        }

        /**
         * Get Preu Unitat.
         * 
         * Aquesta funció retorna el preu per unitat d'un producte a partir d'un array de productes.
         * 
         * @param array $productes És l'array on s'emmagatzemen els productes.
         * @param int $i És l'índex on volem buscar, automàticament ho farà el bucle.
         *
         * @return float Retorna el preu per unitat del producte com a float.
         */
        function getpreuunitat(array $arraypergen, int $i) {
            $pr = $arraypergen[$i][3];  
            return $pr;
        }


        //Començem un bucle per a crear una llista de 10 productess aleatoris
        for($i = 0, $count = count($productes)-1; $i < 10; $i++){

            $itemseleccionat = mt_rand(0,$count);  //seleciona una posició random dins del array gràcies al count
            $prodseleccionat = $productes[$itemseleccionat][0]; // Seleccionem la posico 0 es a dir el productes
            $imatgeruta =  $productes[$itemseleccionat][1]; // Seleccionem la posico 1 es a dir la ruta de la img
            $mesura =  getunitat($productes,$itemseleccionat); // Seleccionem la posico 2 es a dir el metode de mesura
            $preu =  getpreuunitat($productes,$itemseleccionat); // Agafem el preu del producte seleccionat

            // En cas de que la mesura sigui unitaria no aplicarem decimals
            if ($mesura == "manat" or $mesura == "unitat"){
                $quantitat = mt_rand(1, 8);
            }else{
                $quantitat = round(mt_rand(100, 800) / 100, 2); // afegim decimals
            }

            // Definim la variable Subtotal per a poder calcular si n'hi ha descompte
            $subtotal = $quantitat * $preu;

            // En cas de <30 no descompte, en cas de 30-50 5% de descompte, en cas de >50  10%
            if ($subtotal < 30){
                $descompte = 0;
            } elseif ($subtotal >= 30 && $subtotal <= 50){
                $descompte = 5;
            } elseif ($subtotal > 50){
                $descompte = 10;
            };

            // En cas de que el descompte sigui 0 creem la variable preudescomptat i la establim a 0
            // per a evitar fer multiplicacions amb 0 ja que ens trencaria el codi
            if ($descompte == 0){
                $preudescomptat = 0;
            } else {
                $preudescomptat = $subtotal * $descompte / 100;
            }

            
            $import = $subtotal-$preudescomptat;
            
            // Calculem el total de IVA que s'aplicara despres de el descompte
            $ivaaplicat = calcularIVA(NULL,$import);
            $totalpreuproducte = $import + $ivaaplicat;
            // Guardarem tota aquesta informacio en el array que hem definit previament
            // fora del "for", aixi podem emmagatzemar tota la informacio
            $arraypergen[] = [$prodseleccionat,$imatgeruta,$mesura,$preu,$quantitat,$subtotal,$descompte,$preudescomptat,$ivaaplicat,$totalpreuproducte];

        }

        //Per a cada subarray dins del array anirem seleccionant cada variable amb els numeros que fan referència al index
        $i = 0;
        foreach ($arraypergen as $item){
            $maj = substr(getproductes($arraypergen,$i),0,1); //agafo la primera lletra del nom
            $prod = strtoupper($maj)."".substr(getproductes($arraypergen,$i), 1); // La ffaig majuscula i li concateno el resto
            $unit = getunitat($arraypergen,$i);
            $preu = getpreuunitat($arraypergen,$i);
            echo "<tr>
                <td class=img><img src=$item[1]><br>$prod</td>
                <td>$item[4] $unit</td>
                <td>$preu €/$item[2]</td>
                <td>".round($item[5])."€</td>
                <td>{$item[6]}% (-".round($item[7],2)." €)</td>
                <td>".round($item[8],2)." €</td>
                <td>".round($item[9],2)." €</td>
            </tr>";
            $i++;

            //Guardo el nom de cada producte en una llista per a poder fer la llista secundaria despres
            $listaprod[] = $prod;
        }
    echo "</table>";
    
    $listapeq = [];

        
    foreach ($listaprod as $p){
        $f = in_array($p, $listapeq);
        if ($f == true){
            echo "";
        }else{
            $listapeq[] = $p;
        }

    }
    asort($listapeq);
    foreach ($listapeq as $s){
        echo "$s, ";
    }
        ?>
  </body>
</html>
