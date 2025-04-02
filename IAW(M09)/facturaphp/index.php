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
    <table>
        <tr><td>Article</td><td>Quantitat</td><td>Preu/u</td><td>Subtotal</td><td>Descompte</td><td>Iva 21%</td><td>Total</td></tr>
    <?php
       // for ($i = 0, $arrl = count($array); $i < $arrl; $i++){
       //   echo "$array[$i]<br >";
       // }


        // array amb tota la llista de productes del 
        // enunciat amb la seva respectiva informacio
        $producte = [["Patates", "images/patata.jpg","kg",2.05],["Ceba","images/ceba.jpg","kg",2.5] ,["Api","images/api.jpg","manat",3],["Oli Granel","images/oli.jpg","l",8.5],["Pastilla Sabó","images/sabo.jpg","unitat",4.99],["LLuc","images/lluc.jpg","kg",10.55],["Manat de Pastanaga", "images/pastanaga_manat.jpg","manat",3.5]];

        //definim un array per a un ús futur
        $arraypergen = []; 

        //Començem un bucle per a crear una llista de 10 productes aleatoris
        for($x = 0, $count = count($producte)-1; $x < 10; $x++){

            $itemseleccionat = mt_rand(0,$count);  //seleciona una posició random dins del array gràcies al count
            $prodseleccionat = $producte[$itemseleccionat][0]; // Seleccionem la posico 0 es a dir el producte
            $imatgeruta =  $producte[$itemseleccionat][1]; // Seleccionem la posico 1 es a dir la ruta de la img 
            $mesura =  $producte[$itemseleccionat][2]; // Seleccionem la posico 2 es a dir el metode de mesura
            $preu =  $producte[$itemseleccionat][3]; // Agafem el preu del producte seleccionat

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

            // Calculem el total de IVA que s'aplicara despres de el descompte
            $ivaaplicat = (($subtotal - $preudescomptat) * 1.21) - ($subtotal - $preudescomptat);
            // Calculem el preu total que tindra aquest producte
            $totalpreuproducte = (($subtotal - $preudescomptat) * 1.21);
            

            // Guardarem tota aquesta informacio en el array que hem definit previament
            // fora del "for", aixi podem emmagatzemar tota la informacio
            $arraypergen[] = [$prodseleccionat,$imatgeruta,$mesura,$quantitat,$preu,$subtotal,$descompte,$preudescomptat,$ivaaplicat,$totalpreuproducte];            
        }
        
        // Fora del for ordenarem el array per la primera columna que es el nom del producte
        // de forma ascendent aixi s'ordenarà alfabeticament
        $names = array_column($arraypergen, 0);
        array_multisort($names, SORT_ASC, $arraypergen);  
        
        //Per a cada subarray dins del array anirem seleccionant cada variable amb els numeros que fan referència al index
        foreach ($arraypergen as $item){
            echo "<tr>
                <td class=img><img src=$item[1]><br>$item[0]</td>
                <td>$item[3] $item[2]</td>
                <td>$item[4] €/$item[2]</td>
                <td>{$item[5]}€</td>
                <td>{$item[6]}% (-".round($item[7],2)." €)</td>
                <td>".round($item[8],2)." €</td>
                <td>".round($item[9],2)." €</td>
            </tr>";
        }

        ?>
    </table>
  </body>
</html>
