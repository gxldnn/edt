# Database Structure

Client (<ins>DNIClient</ins>, Nom, Adreça, Telf)  
Asumptes (<ins>IdAssumpte</ins>, DataInici, DataArxiu, Estat, *DNIClient*)  
Procurador (<ins>DNIProcurador</ins>, Nom, Adreça, Telf)  
AssumptesProcurador (<ins>IdAssumpte</ins>, <ins>DNIProcurador</ins>)  
