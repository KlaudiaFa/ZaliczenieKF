import oscP5.*;                                                                     // biblioteka do dźwieku  
import netP5.*;                                                                     // biblioteka do dźwięku
import ddf.minim.*;                                                                 // importowanie dźwięku 
int xPos;                                                                           // Pozycja obiektu
int speed=1;                                                                        // Szybkość poruszania się obiektu 
int xDir=1;                                                                         // Kierunek poruszania się obiektu 
int punkty=0;                                                                       // Wynik początkowy 
int szanse =7;                                                                      // Liczba szans 
boolean lost=false;                                                                 // Fukcja ta sprawdza czy już gracz przegrał 
PImage image;                                                                       // Obrazek, który będzie tłem naszej pracy
AudioPlayer player;                                                                 // plik dźwiękowy 
Minim minim;                                                                        // Stworzenie biblioteki dźwięków 

void setup()                                                                        // Wykona te czynności po uruchomieniu programu 
{
  minim = new Minim(this);                                                          // wykreuje nową bibliotekę dźwięku 
  player = minim.loadFile("Gotye - Heart's a Mess (Karaoke).mp3", 2048);            // odtworzenie muzyki poprzez załadowanie odpowiedniego pliku 
  player.play();                                                                    // można odtworzyć i zatrzymać muzykę 
  image = loadImage("tło.jpg");
  size (1000,600);
  smooth();
  xPos=width/2;                                                                     //Wyśrodkuj pozycję obiektu 
  textSize(20);                                                                     //Rozmiar tekstu 

}

void draw()                                                                         //Wstaw tło narysuj obiekt
{
  
  background (image);                                                               //Obrazek w tle
  fill (175,100,220);                                                               // kolor obiektu 
  stroke(5,55,105);                                                                 // obramowanie dla obiektu 
  rect(xPos, height/2, 27, 59,59);                                                  //rysuj obiekt, który będzie się poruszał 
  xPos=xPos+(speed*xDir);                                                           //zmiana pozycji obiektu   
  if (xPos > width-25 || xPos<0)                                                    //Czy obiekt dotknął jednej ze ścian?
  {
    xDir=-xDir;                                                                     //Jeśli obiekten dotknął jedenj ze ścian, niech zmierza w kierunku drugiej i jej też dotknie. 
  }
  fill (255, 0,0);                                                                  // kolor tekstu "punkty"
  text("punkty = "+punkty,width-135,25);                                            //Wświetl liczbę punktów na ekranie
   fill(5,200,225);                                                                 // kolor tekstu "szanse" 
  text("szanse = "+szanse,25,25);                                                   //Wświelt liczbę pozostałych szans
 
  if (szanse<=0)                                                                    //Sprawdź ile szans pozostało do końca gry (program będzie odliczał szanse po każdym kliknięciu w tło a nie w poruszający się obiekt) 
  {
    textSize(60);
     fill (255,204,0);                                                              // kolor tekstu "PRZEGRAŁEŚ - ZACZNIJ OD NOWA"
    text("PRZEGRAŁEŚ - ZACZNIJ OD NOWA", 10,525);
                                
    noLoop();                                                                       //Zatrzymaj pętle w momencie kiedy skończą się wszystkie szanse. 
    lost=true;
    textSize(20);
  }
}

void mousePressed()                                                                 //Obiekt będzie w ruchu nawet jeśli mysz nie będzie używana 
{
  if (dist(mouseX, mouseY, xPos, 300)<=60)                                          //Czy nacisnelismy obiekt i zdobylismy punkt 
  {
    punkty=punkty+speed;                                                            //Wzrost szybkości przy naciśnięciu w poruszjący się obiekt 
    speed=speed+1;                                                                  //Wzrost liczby punktów po poprawnym naciśnięciu w poruszjący się obiekt 
  }
  else                                                                              //albo 
  {  
    if (speed<1)                                                                    //jeśli szybkość mniejsza niż 1 zwiększ szybkość  
    {
    speed=speed-1;
    }
    szanse=szanse-1;                                                                //Zabierz jedną szansę  
  }
  if (lost==true)                                                                   //Jeśli przegrana zacznij grę od nowa 
  {
    speed=1;                                                                        //W przypadku nowej gry liczniki zerują się i wszystko zaczyna się od nowa 
    szanse=7;
    punkty=0;
    xPos=width/2;
    xDir=1;
    lost=false;
    loop();                                                                         //pętla zaczyna się od nowa 
  }
}
