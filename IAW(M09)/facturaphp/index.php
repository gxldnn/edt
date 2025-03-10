<!DOCTYPE html>
<html lang="ca-ES">
  <head>
    <meta charset="utf-8"/>
    <title>Factura Jan Ribera</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/css2.css"> <!-- atenció, cal crear-lo! -->
  </head>
  <body>
    <!--contingut -->
    <h1>Factura</h1>
    <table>
      <tr>
        <th>Article</th>
        <th>Quantitat</th>
        <th>Preu</th>
        <th>Subtotal</th>
        <th>Descompte</th>
        <th>Iva 21%</th>
        <th>Total</th>
      </tr>
      <?php 
        $tcant = 0;
        $tnoiva = 0;
        $tiva = 0;
        for ($x = 1; $x < mt_rand(10,20); $x++) {
          $quantitat = rand(1,5);
          $preu = mt_rand(5,60);
          $subtotal = $quantitat * $preu;
          if ($subtotal < 30) {
            $descompte = 0;
          } elseif ($subtotal >= 30 && $subtotal <= 50) {
            $descompte = 5;
          } elseif ($subtotal > 50) {
            $descompte = 10;
          };
          if ($descompte == 0) {
            $preudescomptat = 0;
          } else {
            $preudescomptat = $subtotal * $descompte / 100;
          }
          $iva = 21;
          $ivares = ($subtotal - $preudescomptat) * $iva / 100;
          $total = $subtotal - $preudescomptat + $ivares;
          echo "</tr>
            <td>Article $x</td>
            <td>$quantitat</td>
            <td>".$preu."€</td>
            <td>".$subtotal."€</td>
            <td>$descompte% (-".$preudescomptat."€)</td>
            <td>".round($ivares, 2)."€</td>
            <td>".round($total, 2)."€</td>
          </tr>";
          $tcant = $tcant + $quantitat;
          $tnoiva = $tnoiva + $subtotal;
          $tiva = $tiva + $total;
        };
      ?>
    </table>
    <?php
      echo "<b>Total Articles</b>: $tcant<br>";
      echo "<b>Preu Total (Sense Iva)</b>: ".$tnoiva."€<br>";
      echo "<b>Preu Total (Amb Iva)</b>: ".round($tiva,2)."€<br>";
    ?>
  </body>
</html>
