# projet ShadowStrike

(désolé d'avance pour les fautes) 

Ce projet consiste à faire un HID malveillant avec une arduino MEGA.
On connectera l'arduino à la cible, selectionnera le programme malveillant avec un joystick et un écran, puis le script s'executera.
Pour faire marcher le .ino , il faut ajouter en zip la librairie HID ici : https://github.com/SFE-Chris/UNO-HIDKeyboard-Library
Cette librairie ne marche pas de base avec le firmware de la mega. On doit donc dans un premier temps transverser le programme .ino a l'arduino, puis ensuite flasher un firmware spéciale pour fonctionner avec la librairie. 
Pour flasher un firmware : instaler Atmel FLIP.
brancher l'arduino, et cours circuiter les pins reset et gnd de l'arduino :
![image](https://github.com/TcLVG/ShadowStrike/assets/118767910/0eb7defb-b18b-42f6-b0dd-57d4b4a26bca)
Ensuite, déconnecter les pin. Sur le gestionnaire de périphérique, un nouveau périphérique inconnu est détecté, il faut installer le pilote.
Aller dans gestionnaire de îlote, installer un pilote présent sur le pc, choisissez comme chemin : C:\Program Files (x86)\Atmel\Flip 3.4.7\usb . 
un périphérique doit donc apparaitre : Atmel16u2. 
Ensuite, sur flip, ouvrez la connexion usb avec l'icone usb, et selectionner le fichier *...*keyboard.hex.
appuyer ensuite sur run, le flash se fait. 
maintenant, dès que vous rebranchez l'araduino, le programme s'execute automatiquement ! 
Pour modifier le programme, vous devrez reflasher le firmware de la mega, *...*mega.hex en suivant les étapes précédentes.
La librairie fonctionne en clavier qwerty, donc mettez vous en clavier anglais avant de brancher l'arduino ! 


