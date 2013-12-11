#include <stdio.h>
#include <stdlib.h>
#include <conio.h>


int rnd(int t)
{
int g;
g = rand() / (32768 / t);
return (g);
}



void main()
{
 struct {
    int hp;
    int df;
    int at;
 } m[15];
 static char *monster[15] = {"Fly", "Bear", "Dear", "Wild Boar", "Pickpocket", "Fairy", "Unicorn", "Troll", "Wisp", "Goblin", "Wyvren", "Basilisk", "Black Knight", "Rock Eater", "Dragon"};
 char *items[16] = {"Nothing", "Blue Key", "Wooden Shield", "Butcher Knife", "Fireball Wand", "Spear", "Chain Mail", "Plate Mail", "long Sword", "Water Bottle", "Invisibility Ring", "Magic Amulet", "Blue Orb", "Silver Key", "Skeleton Key", "Fire Stone"};
 short itn[16]={0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
 int where[16]={0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
 int mhp, mat, mdf;
 int m1, m2, m3;
 int ex=0, lvl=1;
 int at=7, df=7;
 int maxhp = 20;
 int hp = maxhp;
 int or=0;
 int exp = 0;
 int room = 4;
 int maxmp = 4;
 int mp = maxmp;
 int rn=0, rs=0, re=0, rw=0, mc=0;
 char *item = "Old cloth";
 short cur=0;
 char *bb= "                  ";
 char res;
 m[0].hp=2;
 m[0].at=3;
 m[0].df=2;
 m[1].hp=12;
 m[1].at=6;
 m[1].df=10;
 m[2].hp=8;
 m[2].at=9;
 m[2].df=4;
 m[3].hp=9;
 m[3].at=7;
 m[3].df=8;
 m[4].hp=5;
 m[4].at=10;
 m[4].df=4;
 m[5].hp=4;
 m[5].at=2;
 m[5].df=1;
 m[6].hp=5;
 m[6].at=4;
 m[6].df=3;
 m[7].hp=10;
 m[7].at=10;
 m[7].df=8;
 m[8].hp=20;
 m[8].at=8;
 m[8].df=6;
 m[9].hp=5;
 m[9].at=3;
 m[9].df=2;
 m[10].hp=5;
 m[10].at=5;
 m[10].df=2;
 m[11].hp=20;
 m[11].at=8;
 m[11].df=8;
 m[12].hp=12;
 m[12].at=9;
 m[12].df=9;
 m[13].hp=16;
 m[13].at=6;
 m[13].df=10;
 m[14].hp=30;
 m[14].at=2;
 m[14].df=8;
 m[15].hp=20;
 m[15].at=20;
 m[15].df=5;

 for (m1=0;m1<6;m1++)
     {
     do {
     where[m1] = rnd(30)+10;
     or=0;
     for (m2 = 0;m3<m1;m3++);
       if((where[m1]==where[m2])&&(m1!=m2))
          or=1;
     } while (or==1);
     }
 for (m1 = 6; m1 < 16; m1++)
     {
     do {
     where[m1] = rnd(40)+42;
     or=0;
     for (m2 = 0;m3<m1;m3++);
       if((where[m1]==where[m2])&&(m1!=m2))
          or=1;
     }
     while (or==1);
     }
 where[3]=2;
 printf("\n\n\n\n\n\n\n\n\n\n");
 printf("As you wake up you realize what a nice day it is.\n");
 printf("You go to your morning breakfast and suddenly you\n");
 printf("spit out your orange juice and gasp as you watch animals \n");
 printf("go wild outside your window.  You are on a mission to fix\n");
 printf("the problem and bring peace again.\n");
 while (getch() !=32);
 while (hp > 0) {
  if (cur==11)
    {
    mp+=1;
    if(mp>maxmp)
       mp=maxmp;
    }
  if (cur==9)
      hp+=1;
  hp +=1;
  if (hp>maxhp)
   hp=maxhp;

  if (cur==10)
    mc-=3;
  mc+=rnd(2)+3;
  if (room >41)
     mc+=1;
  if (room >63)
     mc+=1;
  if ((room > 0) && (room < 6))
    mc = 0;
  if (room == 40)
   mc +=7;
  if (mc>14)
  {
   printf("\n\nAn Encounter!!\n");
   mc = 0;
   if (room<41)
     {
     m1=rnd(6)+1;
     if (rnd(5)>5)
       m1+=2;
     }
   if (room>41)
     m1=15-rnd(6);

   if (m1<1)
     m1=1;
   if (m1>15)
     m1=15;
   mhp=m[m1].hp;
   mat=m[m1].at;
   mdf=m[m1].df;
   printf("You are engaged in battle with a %s!\n\n", monster[m1]);
   do {
   while (getch() !=32);
    m3=df;
    if (cur == 2)
       m3+=3;
    if (cur == 6)
       m3+=5;
    if (cur == 7)
       m3+=6;

    m2=rnd(mat)*2-rnd(m3);
    if (m2<=0)
        {
        if (m3 == df)
            printf("The %s misses you.\n", monster[m1]);
        if (m3 > df)
            printf("Your %s saves you.\n", item);
        }

    if (m2>0)
      {
        printf("The %s hits you for %d points of damage\n", monster[m1], m2);
        hp -=m2;
      }
    m3=at;
    if (cur == 3)
       m3+=1;
    if (cur == 5)
       m3+=2;
    if (cur == 8)
       m3+=3;
    m2=rnd(m3)-rnd(mdf);
    if (m2<=0)
        printf("     You miss the %s\n", monster[m1]);
    if (m2>0)
      {
        if (m3==at)
            printf("     You hit the %s for %d points of damage\n", monster[m1], m2);
        if (m3 > at)
            printf("     You hit the %s with your %s for %d points of damage\n", monster[m1], item, m2);
        mhp -=m2;
      }
    if (mp > 0)
     {
       m3=rnd(5)+1;
       if ((m3 == 1)&&(mp>1))
         {
         mp=mp-2;
         m2=rnd(2+lvl)+2;
         printf("     You cast Magic missile and cause %d damage!\n", m2);
         mhp=mhp-m2;
         }
       if ((m3 == 2)&&(mp>2))
         {

         mp=mp-3;
         m2=rnd(5+lvl)+1;
         printf("     ");
         if (cur == 4)
           {
           printf("Using your wand, ");
           mp+=5;
           }
         printf("You cast a Fireball that burns the %s for %d\n", monster[m1], m2);
         mhp=mhp-m2;
         }
       if ((m3 == 3)&&(mp>3))
         {
         mp=mp-4;
         m2=rnd(8+lvl)+5;
         printf("     You cast Lightning that frys for %d damage!\n", m2);
         mhp=mhp-m2;
         }
       if ((m3 == 4)&&(mp>13))
         {
         mp=mp-14;
         m2=rnd(20+lvl)+13;
         printf("     You cast Death Cloud for %d points damage!\n", m2);
         mhp=mhp-m2;
         }
       if ((m3 == 5)&&(mp>16))
         {
         mp=mp-12;
         m2=rnd(13+lvl)+20;
         printf("     You cast Earth Quake for %d points damage!\n", m2);
         mhp=mhp-m2;
         }

     }
    }
   while ((mhp > 0) && (hp > 0));
   printf("The battle is over!\n");
   if (hp>0)
    {
    m3=10+rnd(10);
    printf("You win and get %d EXP\n\n", m3);
    ex=ex+m3;
    if (ex>lvl*(20+lvl*5))
     {
       lvl +=1;
       printf("You have jumped a level to %d!\n", lvl);
       maxhp += rnd(4);
       hp=maxhp;
       maxmp += 2+rnd(3);
       mp=maxmp;
       at += rnd(2);
       df += rnd(2);
     }
    }
  }
 if (room == 1)
  {
  rn=6;
  rs=2;
  rw=4;
  re=3;
  printf("You are in the living room of the cottage\n");
  printf("There is a small sofa on the south wall.\n");
  hp +=1;
  if (hp>maxhp)
   hp=maxhp;
  }
  if (room == 2)
  {
   rn=1;
   rs=0;
   rw=0;
   re=0;
   printf("You are in the kitchen.  There are many interentisting\n");
   printf("things here.  The door to the living room is behind you.\n");
  }
  if (room == 3)
  {
   rn=0;
   rs=0;
   rw=1;
   re=0;
   printf("This is the store room, here is a inventory:\n");
   printf("7 Bags of flour\n4 Bags of sugar\nA bale of hay\nPots and Pans\n");
  }
  if (room == 4)
  {
   rn=0;
   rs=5;
   rw=0;
   re=1;
   printf("Inside the bedroom you remember how nice it was before\nthe chaos.  This is so comfortable I could sleep\n");
   if (hp<maxhp)
    printf("You take a small nap.\n");
   hp=maxhp;
  }
  if (room == 5)
  {
   rn=4;
   rs=0;
   rw=0;
   re=0;
   printf("This is a closet.\nIt is  full of cloths and other personal things.\n");
  }
  if (room == 6)
  {
   rn=36;
   rs=1;
   rw=24;
   re=7;
   printf("This is an opening in the forest.\nThere is a cottage to the south.\n");
  }
  if ((room > 6) && (room <24))
    printf("You are in a dark forest.\n");
  if ((room > 23) && (room <29))
    printf("You are in thick woods.\n");
  if ((room > 28) && (room <38))
    printf("You are in a light forest.\n");
  if (room == 7)
   {
   rn=0;
   rs=0;
   rw=6;
   re=8;
   }
  if (room == 8)
   {
   rn=0;
   rs=9;
   rw=7;
   re=0;
   if (rnd(5)==2)
      printf("You see a rabbit run by\n");
   }
  if (room == 9)
   {
   rn=8;
   rs=10;
   rw=0;
   re=15;
   printf("There are birds singing in the trees.\n");
   }
  if (room == 10)
   {
   rn=9;
   rs=0;
   rw=11;
   re=0;
   if (rnd(5)==2)
      printf("You saw a deer in the distance\n");
   }
  if (room == 11)
   {
   rn=0;
   rs=12;
   rw=0;
   re=10;
   if (rnd(5)==2)
      printf("That owl is loud.\n");
   }
  if (room == 12)
   {
   rn=11;
   rs=0;
   rw=18;
   re=13;
   printf("There is a large dead pine tree here.\n");
   }
  if (room == 13)
   {
   rn=14;
   rs=0;
   rw=12;
   re=0;
   if (rnd(5)==2)
      printf("A mouse has just scurried by\n");
   }
  if (room == 14)
   {
   rn=0;
   rs=13;
   rw=0;
   re=14;
   if (rnd(5)==2)
      printf("You saw a deer in the distance\n");
   }
  if (room == 15)
   {
   rn=16;
   rs=0;
   rw=9;
   re=0;
   printf("This oak tree has nice shade.\n");
   hp +=1;
   if (hp>maxhp)
        hp=maxhp;
   }
  if (room == 16)
   {
   rn=35;
   rs=15;
   rw=17;
   re=0;
   if (rnd(5)==2)
      printf("The ground has just shifted!\n");
   }
  if (room == 17)
   {
   rn=37;
   rs=0;
   rw=0;
   re=16;
   if (rnd(5)==2)
        {
      printf("Ouch ants are a pain in the...\n");
      hp-=1;
      }
   }
  if (room == 18)
   {
   rn=0;
   rs=0;
   rw=19;
   re=12;
   printf("Weeping willows are sad looking trees.\n");
   if (rnd(5)==2)
      printf("I think I saw a tear drop!\n");
   }
  if (room == 19)
   {
   rn=20;
   rs=0;
   rw=0;
   re=18;
   printf("You see a lake to the west.\n");
   if (rnd(5)==2)
     printf("A fish has just jumped out of the water!\n");
   }
  if (room == 20)
   {
   rn=0;
   rs=19;
   rw=21;
   re=0;
   printf("You hear waves to the southwest.\n");
   }
  if (room == 21)
   {
   rn=22;
   rs=0;
   rw=0;
   re=20;
   printf("There is a lake to the south.\n");
   if (rnd(5)==2)
      printf("Those birds know how to get food.\n");
   }
  if (room == 22)
   {
   rn=0;
   rs=21;
   rw=0;
   re=23;
   if (rnd(5)==2)
      printf("That rabbit scared me!\n");
   }
  if (room == 23)
   {
   rn=24;
   rs=0;
   rw=22;
   re=0;
   printf("The ground is white from the dogwood blossoms.\n");
   }
  if (room == 24)
   {
   rn=25;
   rs=23;
   rw=0;
   re=6;
   if ((rnd(10)==2)&&(cur!=1))
      {
      printf("A pickpocket just ran by and stole your %s\n", item);
        item="Thieves notice";
        cur=0;
      }
   }
  if (room == 25)
   {
   rn=0;
   rs=24;
   rw=27;
   re=26;
   printf("The poisin ivy is irriting you.\n");
   hp -=1;
   }
  if (room == 26)
   {
   rn=31;
   rs=40;
   rw=25;
   re=00;
   printf("You see a small hut to the south.\n");
   }
  if (room == 27)
   {
   rn=28;
   rs=0;
   rw=0;
   re=25;
   if ((rnd(9)==2)&&(cur != 1))
     {
      printf("A peddlar has traded your %s for an Axe!!\n", item);
      item="Great Axe      ";
      cur=8;
     }
   }
  if (room == 28)
   {
   rn=0;
   rs=27;
   rw=0;
   re=29;
   printf("It is very muddy here.\n");
   }
  if (room == 29)
   {
   rn=30;
   rs=0;
   rw=28;
   re=0;
   printf("You are on a shallow place on the river.\nyou can pass here.\n");
   }
  if (room == 30)
   {
   rn=38;
   rs=29;
   rw=0;
   re=31;
   printf("You see a clearing to the north.\n");
   }
  if (room == 31)
   {
   rn=0;
   rs=26;
   rw=30;
   re=32;
   }
  if (room == 32)
   {
   rn=33;
   rs=36;
   rw=31;
   re=0;
   if (rnd(10)>5)
     {
     printf("You are taken by suprise by arrows coming from the trees.\n");
     m1 = rnd(4)+1;
     for (m2=0;m2<m1;m2++)
       {
        printf("Ouch!!\n");
        hp-=1;
       }
     }
   }
  if (room == 33)
   {
   rn=0;
   rs=32;
   rw=0;
   re=34;
   if (mp<maxmp)
    {
      printf("You feel more magical!\n");
      mp+=1;
    }
   }
  if (room == 34)
   {
   rn=39;
   rs=37;
   rw=33;
   re=35;
   printf("There is light to the north.\n");
   }
  if (room == 35)
   {
   rn=0;
   rs=16;
   rw=34;
   re=0;
   if (rnd(5)==2)
      {
      printf("This forest seems so peaceful.\n");
      mp=maxmp;
      }
   }
  if (room == 36)
   {
   rn=32;
   rs=6;
   rw=0;
   re=0;
   printf("You are on a big bridge over a clear stream.\n");
   }
  if (room == 37)
   {
   rn=34;
   rs=17;
   rw=0;
   re=42;
   printf("You see a dungeon to the east.\n");
   if (rnd(5)==2)
      printf("You hear demonic howls from within\n");
   if ((cur != 1)&&(cur != 14))
     {
     printf("You need a blue key to unlock the door!\n");
     re=-1;
     }
   }
  if (room == 38)
   {
   rn=38;
   rs=30;
   rw=38;
   re=39;
   printf("You are in a great field.\n");
   printf("There is an opening to the east.\n");
   if (rnd(5)==2)
      printf("A rabbit has just ran by.\n");
   }
  if (room == 39)
   {
   rn=39;
   rs=34;
   rw=38;
   re=39;
   printf("You are in a great field.\n");
   printf("There is an opening to the west.\n");
   if (rnd(5)==2)
      printf("The waves of grains look beautiful.\n");
   }
  if (room == 40)
   {
   mc=0;
   rn=26;
   rs=00;
   rw=00;
   re=00;
   printf("You are in a small hut.\nIt is sure nice here.\n");
   if (mp<maxmp)
    {
       mp=maxmp;
       printf("Your magic powers are regained!.\n");
    }
   }
 if ((room >5)&&(room <41))
    {
      m1 = rnd(40);
      if (m1==1)
         printf("The wind rustles the leaves.\n");
      if (m1==2)
         printf("The wind whistles through the trees.\n");
      if (m1==3)
         printf("The ground is damp under your feet.\n");
      if (m1==4)
         {
         printf("You find a magic acorn!\n");
         mp+=1;
         if (mp>maxmp)
           mp=maxmp;
         }
      if (m1==5)
         {
         printf("You find a magic apple!\n");
         mp+=1;
         if (mp>maxmp)
           mp=maxmp;
         }
      if (m1==6)
         printf("The wind rustles the leaves.\n");
      if (m1==8)
         printf("A pinecone falls behind you.\n");
      if (m1==9)
         printf("There are wild hogs running by.\n");
      if (m1==10)
         printf("You catch a sweet breath of flower scent.\n");
      if (m1==11)
         {
         printf("You get tangled in thorns.\n");
         hp-=1;
         }
      if (m1==12)
         {
         printf("You trip on a dead branch!.\n");
         hp-=1;
         }
      if (m1==13)
         printf("A buck is eating some grass, hears you, and runs away.\n");
      if (m1==14)
         {
         printf("You feel a little better.\n");
         mp+=1;
         hp+=1;
         if (mp>maxmp)
           mp=maxmp;
         if (hp>maxhp)
           hp=maxhp;
         }
      if (m1==15)
         printf("You hear bird songs.\n");
      if (m1==16)
         printf("You see a small elf. He thinks you are a monster and runs away.\n");
      if (m1==17)
         printf("You see many small elves playing hide and seek who suddenly vanish.\n");
      if (m1==18)
         printf("The wet leaves stick to your boots.\n");
      if (m1==19)
         printf("You trip in a pothole and get muddy.\n");
    }

  if (room == 42)
   {
   rn=0;
   rs=37;
   rw=50;
   re=43;
   printf("The exit is to the south.\n");
   if (or<42)
     printf("As you enter the dungeon you have a feeling of foreboding.\n");
   if ((cur != 1)&&(cur != 14))
     {
     printf("You need a blue key to unlock the door to the south.\n");
     rs=-1;
     }

   }
  if (room == 43)
   {
   rn=44;
   rs=0;
   rw=42;
   re=58;
   printf("There are holes in the ground to the north.\n");
   }
  if (room == 44)
   {
   rn=0;
   rs=43;
   rw=45;
   re=0;
   printf("There are holes under your feet.\n");
   if (rnd(10)>5)
    {
      printf("Suddenly, arrows shoot up through the holes!\n");
      hp-=4+rnd(6);
    }
   }
  if (room == 45)
   {
   rn=46;
   rs=0;
   rw=0;
   re=44;
   }
  if (room == 46)
   {
   rn=0;
   rs=45;
   rw=47;
   re=55;
   }
  if (room == 47)
   {
   rn=0;
   rs=48;
   rw=54;
   re=46;
   }
  if (room == 48)
   {
   rn=47;
   rs=0;
   rw=49;
   re=0;
   }
  if (room == 49)
   {
   rn=0;
   rs=50;
   rw=52;
   re=48;
   }
  if (room == 50)
   {
   rn=49;
   rs=0;
   rw=0;
   re=42;
   }
  if (room == 51)
   {
   rn=52;
   rs=61;
   rw=0;
   re=0;
   printf("There is a bright blue portal shimmering to the south.\n");
   if (or == 61)
       printf("That must be how I got here.\nI just teleported.\n");
   }
  if (room == 52)
   {
   rn=53;
   rs=51;
   rw=0;
   re=49;
   }
  if (room == 53)
   {
   rn=63;
   rs=52;
   rw=0;
   re=54;
   }
  if (room == 54)
   {
   rn=62;
   rs=0;
   rw=53;
   re=47;
   }
  if (room == 55)
   {
   rn=59;
   rs=0;
   rw=46;
   re=56;
   }
  if (room == 56)
   {
   rn=0;
   rs=57;
   rw=55;
   re=0;
   }
  if (room == 57)
   {
   rn=56;
   rs=58;
   rw=0;
   re=0;
   }
  if (room == 58)
   {
   rn=57;
   rs=0;
   rw=43;
   re=0;
   }
  if (room == 59)
   {
   rn=0;
   rs=55;
   rw=60;
   re=0;
   printf("You hear something to the west\n");
   }
  if (room == 60)
   {
   rn=0;
   rs=0;
   rw=0;
   re=59;
   printf("You see a great sparkling fountain.\n");
   printf("The water looks almost magical.\n");
   if (mp<maxmp)
    {
      mp=maxmp;
      printf("As you drink the water, you magic is restored!.\n");
    }
   }
  if (room == 61)
   {
   rn=0;
   rs=0;
   rw=62;
   re=51;
   printf("There is a bright blue portal shimmering to the east.\n");
   if (or == 51)
       printf("That must be how I got here.\nI just teleported!\n");
   }
  if (room == 62)
   {
   rn=0;
   rs=54;
   rw=0;
   re=61;
   printf("There is a light coming from the east.\n");
   }
  if (room == 63)
   {
   rn=0;
   rs=53;
   rw=64;
   re=0;
   printf("You see some stairs going deeper into the dungeon to the west.\n");
   if (or == 64)
            printf("You are sure glad to leave there.\n");
   }
  if (room == 64)
   {
   rn=72;
   rs=0;
   rw=65;
   re=63;
   printf("The stair back up is east.\n");
   if (or == 63)
     {
     printf("The bad air takes you by surprize and chokes you!\n");
     hp-=2;
     }
   }
  if (room == 65)
   {
   rn=66;
   rs=0;
   rw=68;
   re=64;
   }
  if (room == 66)
   {
   rn=0;
   rs=65;
   rw=67;
   re=0;
   printf("There is a erie red light coming from the west.\n");
   }
  if (room == 67)
   {
   rn=0;
   rs=0;
   rw=82;
   re=66;
   printf("There is a erie red portal bubling to the west.\n");
   if (or == 82)
        {
       printf("The portal caused damage to your health!\n");
       hp-=2+rnd(1);
       }
   }
  if (room == 68)
   {
   rn=0;
   rs=0;
   rw=69;
   re=65;
   printf("There is a dancing red light to the west.\n");
   }
  if (room == 69)
   {
   rn=70;
   rs=0;
   rw=0;
   re=68;
   printf("There is fire everywhere!\n");
   if (rnd(10)>5)
    {
     printf("You are burned by the fire!\n");
     hp-=4;
    }
   if (rnd(10)>7)
    {
     printf("You are severly burned by the fire!\n");
     hp-=7;
    }
   }
  if (room == 70)
   {
   rn=0;
   rs=69;
   rw=0;
   re=71;
   printf("There is a dancing red light to the south.\n");
   }
  if (room == 71)
   {
   rn=0;
   rs=0;
   rw=70;
   re=0;
   printf("This is a dead end.\n");
   printf("There is a crack in the wall.\n");
   }
  if (room == 72)
   {
   rn=0;
   rs=64;
   rw=73;
   re=0;
   }
  if (room == 73)
   {
   rn=80;
   rs=0;
   rw=74;
   re=72;
   }
  if (room == 74)
   {
   rn=75;
   rs=0;
   rw=0;
   re=73;
   }
  if (room == 75)
   {
   rn=0;
   rs=74;
   rw=76;
   re=0;
   }
  if (room == 76)
   {
   rn=77;
   rs=0;
   rw=0;
   re=75;
   }
  if (room == 77)
   {
   rn=0;
   rs=76;
   rw=0;
   re=78;
   }
  if (room == 78)
   {
   rn=0;
   rs=79;
   rw=77;
   re=0;
   printf("There is a huge hole in the ground to the south.\n");
   }
  if (room == 79)
   {
   rn=78;
   rs=0;
   rw=0;
   re=80;
   printf("You are over a magic hole.\nIt is a very dark vacuem.\n");
   if (mp>0)
    {
      printf("All your magic power is drained.\n");
      mp=0;
    }
   }
  if (room == 80)
   {
   rn=0;
   rs=73;
   rw=79;
   re=81;
   printf("It is dark to the west.\n");
   }
  if (room == 81)
   {
   rn=83;
   rs=82;
   rw=80;
   re=0;
   printf("There is a blood-red glow to the south.\n");
   }
  if (room == 82)
   {
   rn=81;
   rs=67;
   rw=0;
   re=0;
   printf("There is a erie red portal bubling to the south\n");
   if (or == 67)
        {
       printf("The portal caused damage to your health!\n");
       hp-=2+rnd(1);
       }

   }
  if (room == 83)
   {
   rn=0;
   rs=81;
   rw=84;
   re=0;
   printf("There is a friendly glow to the west.\n");
   }
  if (room == 84)
   {
   rn=0;
   rs=0;
   rw=85;
   re=83;
   printf("You are directly outside of a nice underground house.\n");
   if ((cur != 13)&&(cur != 14))
     {
       printf("The door is locked\n");
       printf("You need the silver key.\n");
       rw=-1;
     }
   }
  if (room == 85)
   {
   mc=0;
   rn=0;
   rs=0;
   rw=86;
   re=84;
   printf("It is warm in here.  You feel safe from the monsters.\n");
   }
  if (room == 86)
   {
   rn=0;
   rs=0;
   rw=0;
   re=85;
   printf("There is a bed in here.\n");
   if (hp<maxhp)
    printf("You take a small nap.\n");
   hp=maxhp;
   }
  if ((room >41)&&(room<64))
     {
     printf("You are in the first level of a dungeon.\The walls and floor are brick.\n");
     m1=rnd(20);
     if (m1 == 1)
        printf("A mouse has just scurried by.\n");
     if (m1 == 2)
        printf("You hear horrible screaming.\n");
     if (m1 == 3)
        printf("A shadow just flew by.\n");
     if (m1 == 4)
        printf("There is a constant dripping sound.\n");
     if (m1 == 5)
        printf("That cackling was horrible.\n");
     if (m1 == 6)
        printf("A mouse has just scurried by.\n");
     }
  if (room >63)
     {
     printf("You are in the second level of the dungeon.\nIt is very dark and damp.\n");
     m1=rnd(20);
     if (m1 == 1)
        printf("A mouse has just scurried by.\n");
     if (m1 == 2)
        printf("You hear horrible screaming.\n");
     if (m1 == 3)
        printf("A shadow just flew by.\n");
     if (m1 == 4)
        printf("There is a constant dripping sound.\n");
     if (m1 == 5)
        printf("That cackling was horrible.\n");
     if (m1 == 6)
        printf("A mouse has just scurried by.\n");
     if (m1 == 7)
        printf("The walls are bleeding!!!\n");
     if (m1 == 8)
        {
        printf("A gas cloug chokes you!.\n");
        hp-=2;
        }
     if (m1 == 9)
         {
        printf("You tripped and a fairy stole your magic.\n");
        mp-=5;
        if (mp<0)
          mp=0;
        }
     }

if (hp>0)
{
 do {

 printf("\nCan go:");
 if (rn>0)
  printf(" North");
 if (rs>0)
  printf(" South");
 if (re>0)
  printf(" East");
 if (rw>0)
  printf(" West");
  printf("\nCommand:");
  res=0;
  while (res == 0)
    res=getch();

  or = room;
  if ((res == 'l') || (res == 'L'))
  {
  printf("Look\n\n");
  m1 = 0;
  for (m2 = -1;m2 <= 15;m2++)
    if (where[m2] == room)
       m1 = m2;
  if (m1 > 0)
   {
   bb = item;
   m3=cur;
   item = items[m1];
   cur=itn[m1];
   items[m1] = bb;
   itn[m1]=m3;
   printf("You have dropped your %s and picked up a %s.\n", items[m1], item);
   }
  if (m1 == 0)
    printf("You find nothing\n");

  }

  if ((res == 'z') || (res == 'Z'))
  {
    printf("\nZ-Stats\n\n");
    printf("EXP %d\n", ex);
    printf("Level %d\n", lvl);
    printf("HP  %d/%d\n", hp, maxhp);
    printf("MP  %d/%d\n", mp, maxmp);
    printf("You have: %s\n", item);
    printf("Spells:\n");
    if (maxmp>1)
      printf("Magic Missile\n");
    if (maxmp>2)
      printf("Fireball\n");
    if (maxmp>3)
      printf("Lightning\n");
    if (maxmp>13)
      printf("Death Cloud\n");
    if (maxmp>16)
      printf("Earthquake\n");
    printf("\n\n");
  }
  if ((res == 'n')||(res == 'N')||(res == '8'))
    {
    room = rn;
    printf("North\n\n");
    }
  if ((res == 's')||(res == 'S')||(res == '2'))
    {
    room = rs;
    printf("South\n\n");
    }
  if ((res == 'e')||(res == 'E')||(res == '6'))
    {
    room = re;
    printf("East\n\n");
    }
  if ((res == 'w')||(res == 'W')||(res == '4'))
    {
    room = rw;
    printf("West\n\n");
    }
  if ((res == 'd') || (res == 'D'))
    {
    or=0;
    printf("Description\n\n");
    }
  if (room == 0)
  {
    printf("\nYou can't go that direction!!!\n\n");
    room = or;
  }
  if (room == -1)
  {
    printf("\nI said the door is locked!!!\n\n");
    room = or;
  }
 }
 while (room == or);
 }
 }
dead:
printf("\n\nYou Have Died!!!\n");
while (getch()!=32);
return;
}
