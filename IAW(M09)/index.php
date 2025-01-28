<!DOCTYPE html>
<html lang="ca-ES">
  <head>
    <meta charset="utf-8"/>
    <title>Pàgina de Jan Ribera</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="estils/estil.css"> <!-- atenció, cal crear-lo! -->
  </head>
  <style>
    @import url("https://fonts.googleapis.com/css2?family=Poppins&display=swap");
    body {
      background-image: url(https://media.tenor.com/pBR6qPBzNUUAAAAM/suit-nle-choppa.gif);
      background-size:500px;

    }
    table {
      border-collapse: collapse;
      width: 50%;
      margin: 20px auto;
    }
    th, td {
      border: 1px solid black;
      text-align: center;
      padding: 10px;
    }
    </style>
  <body>

    
    <!--contingut -->
    <h1>Taula de Multiplicar</h1>

    <table>
    <?php

      echo "<tr>";
      echo "<th>X</th>";
      for ($i = 1; $i <= 10; $i++){
      echo "<th>$i</th>";
      }
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
