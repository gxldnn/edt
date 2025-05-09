<html>
<link rel="stylesheet" href="css/css.css">
    <body>
        <?php
            /*function printdump(array $listapeticiones){
                echo "<ul>";
                foreach ($listapeticiones as $i){
                    echo "$i    ";
                }
*/

                /*
                if (isset($_POST['nom'])){
                    echo "<br><br><br>
                    Les dades rebudes son aquestes:<br><br>
                    <ul>
                        <li>\$_GET:<span class ='hola'>Numero de Interessos = ".count($listainteressos)."</span></li>
                        <li>\$_POST: <span class='hola'>nom = ".$_POST["nom"]."</span> <span class='hola'>Correu = ".$_POST["correu"]."</span> <span class='hola'>Data Naixement = ".$_POST["data"]."</span> <span class='hola'>Nivell de calma = ".$_POST["calma"]."</span> <span class='hola'>Numero de Interessos = ".count($listainteressos)."</span></li>
                        <li>\$_REQUEST: <span class='hola'>nom = ".$_REQUEST["nom"]."</span> <span class='hola'>Correu = ".$_REQUEST["correu"]."</span> <span class='hola'>Data Naixement = ".$_REQUEST["data"]."</span> <span class='hola'>Nivell de calma = ".$_REQUEST["calma"]."</span> <span class='hola'>Numero de Interessos = ".count($listainteressos)."</span></li>                
                    </ul>";
                } else{
                    echo "<br><br><br>
                    Les dades rebudes son aquestes:<br><br>
                    <ul>
                        <li>\$_GET: <span class ='hola'>nom = ".$_GET["nom"]."</span> <span class ='hola'>Correu = ".$_GET["correu"]."</span> <span class ='hola'>Data Naixement = ".$_GET["data"]."</span> <span class ='hola'>Nivell de calma = ".$_GET["calma"]."</span> <span class ='hola'>Numero de Interessos = ".count($listainteressos)."</span></li>
                        <li>\$_POST: <span class='hola'>Numero de Interessos = ".count($listainteressos)."</span></li>
                        <li>\$_REQUEST: <span class='hola'>nom = ".$_REQUEST["nom"]."</span> <span class='hola'>Correu = ".$_REQUEST["correu"]."</span> <span class='hola'>Data Naixement = ".$_REQUEST["data"]."</span> <span class='hola'>Nivell de calma = ".$_REQUEST["calma"]."</span> <span class='hola'>Numero de Interessos = ".count($listainteressos)."</span></li>                
                    </ul>";
                }
                */
            //}
            
            if (isset($_POST['nom'])){

                echo "(\$_POST) --> Hola ".$_POST["nom"]." <br>";
                echo "(\$_POST) --> El teu correu es: ".$_POST["correu"]."<br>";
                echo "(\$_POST) --> Vas neixer el: ".$_POST["data"]."<br>";
                echo "(\$_POST) --> El teun nivell de calma es: ".$_POST["calma"]."<br>";
                echo "(\$_POST) --> Els teus interesos son:"; 
                echo "<ul>";
            
                $listainteressos = explode(",",$_POST["interessos"]);
                
                foreach ($listainteressos as $a){
                    echo "<li>$a</li>";
                }

            } else{
                echo "(\$_GET) --> Hola ".$_GET["nom"]." <br>";
                echo "(\$_GET) --> El teu correu es: ".$_GET["correu"]."<br>";
                echo "(\$_GET) --> Vas neixer el: ".$_GET["data"]."<br>";
                echo "(\$_GET) --> El teun nivell de calma es: ".$_GET["calma"]."<br>";
                echo "(\$_GET) --> Els teus interesos son:"; 
                echo "<ul>";
            
                $listainteressos = explode(",",$_GET["interessos"]);    
                
                foreach ($listainteressos as $a){
                    echo "<li>$a</li>";
                }
            }

            $listapeticiones["POST"] = $_POST;
            $listapeticiones["GET"] = $_GET;
            $listapeticiones["REQUEST"] = $_REQUEST;
            
            var_dump($listapeticiones);
            /*function printdump(array $listapeticiones){
                echo "<ul>";
                $z = 0;
                foreach ($listapeticiones as $x => $i){
                    echo "$x<br>";
                    $z++;
                }
            }*/
            function printdump(array $listapeticiones, array $listainteressos){
                echo "Les dades rebudes són aquestes:<br><br>";
                echo "<ul>";
                foreach ($listapeticiones as $metode => $dades) {
                    echo "<li>"."\$_"."$metode: ";
                    if (empty($dades)) {
                        echo "<span class='hola'>(No hi han dades)</span>";
                    } else {
                        foreach ($dades as $clau => $valor) {
                            echo "<span class='hola'>$clau = $valor</span> ";
                        }
                        if ($metode === "GET" || $metode === "POST" || $metode === "REQ") {
                            echo "<span class='hola'>Numero de Interessos = " . count($listainteressos) . "</span>";
                        }
                    }
                    echo "</li>";
                }
                echo "</ul>";
            }
            
            @printdump($listapeticiones, $listainteressos);
            
        ?>
        </ul>
    </body>
</html>
