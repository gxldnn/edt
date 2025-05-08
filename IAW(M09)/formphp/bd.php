<html>
    <body>
        Hola <?php echo $_POST["nom"]; ?><br>
        El teu correu es: <?php echo $_POST["correu"]?><br>
        Vas neixer el: <?php echo $_POST["data"]?><br>
        El teun nivell de calma es: <?php echo $_POST["calma"]?><br>
        Els teus interesos son: 
        <ul>
            <?php
                $listainteressos= explode(",",$_POST["interessos"]);
                
                foreach ($listainteressos as $a){
                    echo "<li>$a</li>";
                }
            ?>
        </ul>
    </body>
</html>
