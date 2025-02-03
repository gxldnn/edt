<!DOCTYPE html>
<html lang="ca-ES">
  <head>
    <meta charset="utf-8"/>
    <title>Pàgina de Jan Ribera</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
  </head>

  <body>

    
    <!--contingut -->
    <h1>Taula de Multiplicar</h1>

    <table>
    <colgroup>
      <col span="2">
      <col span = "1" style="background-color:yellow">
    </colgroup>
    <?php
      echo "<tr>";
      for ($i = 1; $i <= 10; $i++){
        if ($i == 1){
          echo "<th>X</th>";
        }
        echo "<th>$i</th>";
      }
      echo "</tr>";
      for ($y = 1 ;$y <= 10; $y++) {
        echo "<tr>";
        echo "<th>$y</th>";
        for ($x = 1; $x <=10; $x++){

          echo "<td>". $y * $x ."</td>";
        }
        echo "</tr>";
      }
      
    
    ?>
    </table>

    <h1>Llista de la taula</h1>
      <?php
      for ($x = 1; $x <= 10; $x++){
        echo "<ul>Taula del $x";
        for ($y = 1; $y <= 10; $y++)
          echo "<li>$x * $y = " .$x * $y."";
          echo "</ul>";
      }
      ?> 

  </body>
</html>
