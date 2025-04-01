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

        $producte = [["Patates", "images/patata.jpg","kg",2.05],["Ceba","images/ceba.jpg","kg",2.5] ,["Api","images/api.jpg","manat",3],["Oli Granel","images/oli.jpg","l",8.5],["Pastilla Sabó","images/sabo.jpg","unitat",4.99],["LLuc","images/lluc.jpg","kg",10.55],["Manat de Pastanaga", "images/pastanaga_manat.jpg","manat",3.5]];
    
        for($x = 0, $count = count($producte)-1; $x < 10; $x++){

            $itemseleccionat = rand(0,$count);
            $prodseleccionat = $producte[$itemseleccionat][0];
            $imatgeruta =  $producte[$itemseleccionat][1];
            $mesura =  $producte[$itemseleccionat][2];
            $quantitat = mt_rand(1,8);
            $preu =  $producte[$itemseleccionat][3];    
            $subtotal = $quantitat * $preu;
            if ($subtotal < 30){
                $descompte = 0;
            } elseif ($subtotal >= 30 && $subtotal <= 50){
                $descompte = 5;
            } elseif ($subtotal > 50){
                $descompte = 10;
            };
            if ($descompte == 0){
                $preudescomptat = 0;
            } else {
                $preudescomptat = $subtotal * $descompte / 100;
            }
            $ivaaplicat = (($subtotal - $preudescomptat) * 1.21) - ($subtotal - $preudescomptat);
            $totalpreuproducte = (($subtotal - $preudescomptat) * 1.21);
            
            $arraypergen = [$prodseleccionat,$imatgeruta,$mesura,$quantitat,$preu,$subtotal,$descompte,$ivaaplicat,$totalpreuproducte];
            sort($arraypergen);            

        }
        $x = 0
        foreach ($arraypergen as $orden){
            echo "<tr>
                <td class=img><img src={$orden[$x][2]}><br>$prodseleccionat</td>
                <td>$quantitat $mesura</td>
                <td>$preu €/$mesura</td>
                <td>{$subtotal}€</td>
                <td>{$descompte}% (-".round($preudescomptat,2)." €)</td>
                <td>".round($ivaaplicat,2)." €</td>
                <td>".round($totalpreuproducte,2)." €</td>
            </tr>";   
            $x++
        }
    

        ?>
        <?php

    
        
        ?>
    </table>
  </body>
</html>

