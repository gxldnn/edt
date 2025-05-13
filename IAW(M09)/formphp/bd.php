<html>
<link rel="stylesheet" href="css/css.css">
    <body>
        <?php
            switch($_POST["calma"]){
                case 0:
                case 1:
                case 2:
                case 3:
                    echo "estressada";
                    break;
                case 4:
                case 5:
                case 6:
                case 7:
                    echo "normalet";
                    break;
                case 8:
                case 9:
                    echo "zen";
                    break;
                case 10:
                    echo "samadhi";
                    break;
            }
            
            switch($_GET["calma"]){
                case 0:
                case 1:
                case 2:
                case 3:
                    echo "estressada";
                    break;
                case 4:
                case 5:
                case 6:
                case 7:
                    echo "normalet";
                    break;
                case 8:
                case 9:
                    echo "zen";
                    break;
                case 10:
                    echo "samadhi";
                    break;
            }switch($_REQUEST["calma"]){
                case 0:
                case 1:
                case 2:
                case 3:
                    echo "estressada";
                    break;
                case 4:
                case 5:
                case 6:
                case 7:
                    echo "normalet";
                    break;
                case 8:
                case 9:
                    echo "zen";
                    break;
                case 10:
                    echo "samadhi";
                    break;
            }
   
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
                        if ($metode === "GET" || $metode === "POST" || $metode === "REQUEST") {
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
