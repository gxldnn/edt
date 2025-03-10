<!DOCTYPE html>
<html lang="ca-ES">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/css.css"> <!-- atenció, cal crear-lo! -->
        <title>Exercicis Curts</title>
    </head>
    <body>
        <?php
            // Programa que comprova si una variable és major que zero o no. $n=-23 → dirà "-23 no és major que zero"
            echo "<br><br>";
            echo "<h1>Ex. 1</h1>";


            $variable = -23; // Asignem un numero a una variable
            if ($variable < 0){ // comprovem si variable es menor que 0
                echo "$variable no és major que zero<br>";
            } elseif ($variable > 0) { // comprovem si variable es major que 0
                echo "$variable és major que zero<br>";
            } else { // per logica si no es ni menor ni major que 0 ha de ser 0 "Per aixo el else i no un altre elseif"
                echo "$variable es 0";
            }

            
            
            
            

            
            
            //  Programa semblant a l'anterior, però que dirà si la variable és positiva, negativa o zero.
            echo "<br><br>";
            echo "<h1>Ex. 2</h1>";

            $variable = 23; // Asignem un numero a una variable
            if ($variable < 0){ // comprovem si variable es menor que 0
                echo "$variable es un numero negatiu<br>";
            } elseif ($variable > 0) { // comprovem si variable es major que 0
                echo "$variable es un numero positiu<br>";
            } else { // per logica si no es ni menor ni major que 0 ha de ser 0 "Per aixo el else i no un altre elseif"
                echo "$variable es zero";
            }

            
            


            
            
            
            
            // A partir del preu recollit a una variable, i el número d'unitats en una altra
            // el programa et dirà: preu amb IVA (21%) i si cal, preu amb descompte. El descompte (5%)
            // s'aplica si el total resultant és major que 300€.
            echo "<br><br>";
            echo "<h1>Ex. 3</h1>";


            $preu = 54  ; //posem un preu
            $unitats = 5; // posem un altre variable
            $preutotal = $preu * $unitats * 1.21; // Multipliquem el preu per la cuantitat i sumem el IVA
            echo "Preu amb IVA: $preutotal<br>"; // Mostrem el preu total

            if ($preutotal > 300){ // Comprovem que el preu total es major a 300
                $preutotal = $preutotal * 0.95; // En el cas multipliquem per 0.95 ja que aixi li restem un 5%
                echo "Preu descomptat (-5%): $preutotal"; // Mostra el preu descomptat
            } elseif ($preutotal <= 300){ // Comprovem que el preu no sigui major a 300
                    echo "Preu descomptat (-0%): <b>No aplica a descompte</b>"; // Mostra que no hi ha descompte ja que no cmpleix amb l'enunciat
            
            }







            // Comences amb dues variables, $a i $b, amb valors assignats.
            // Cal que les reordenis, si cal, de manera que $a sigui menors que $b
            // i després les treus per pantalla ("$a = 15 i $b=25")
            echo "<br><br>";
            echo "<h1>Ex. 4</h1>";


            // Asignem valors a les variables
            
            $a = 34;
            $b = 2312;
            $x = 0;

            if($a > $b){ // En el cas de que A sigui major a B
                $x = $a; // Guardem el valor provisionalment de A a la variable temporal X
                $a = $b; // Ara A pot asumir el valor de B
                $b = $x; // B agafa el valor previament emmagatzemat de A que esta en X
                echo "a = $a,  b = $b"; // Mostrem en ordre
            } else{       // En el cas de que no cumpleixi, mostra sense ordenar 
             echo "a = $a,  b = $b"; // Mostrem
            }







            // El mateix que l'anterior, però amb 3 variables, $a, $b i $c
            echo "<br><br>";
            echo "<h1>Ex. 5</h1>";

            // Asignem valors a les variables
            $a = 2;
            $b = 1;
            $c = 0;
            $x = 0;

            if ($b > $c){ // En el cas de que B sigui major que C, fes:
                $x = $b; // Guardem el valor de B en la variable temporal X
                $b = $c; // Ara B pot asumir el valor de C
                $c = $x; // C agafa el valor emmagatzemat de B en X
            }
            // Ara tenim per segur que b es mes petit que c pero no sabem si a es mes gran que b

            if($a > $b){ // En el cas de que a sigui major que B, fes:
                $x = $a; // Guardem el valor de A en la variable temporal X
                $a = $b; // Ara A pot asumir el valor de B
                $b = $x; // B agafa el valor emmagatzemat de A en X
            }
            // Ara tenim per segur que A es mes petit que B i que C, pero no sabem si ara B es major que C, es repeteix el primer if
            // ja que es la mateixa situació

            if ($b > $c){
                $x = $b;
                $b = $c;
                $c = $x;
            }

            echo "a = $a,  b = $b, c = $c"; // Mostrem el resultat ordenat
        ?>
    </body>
</html>
