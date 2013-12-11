// Tim Caswell
// 10-9-98
// Object class for characters is rpg's and action games

#define BAGSIZE 20

class character
{
protected:
   int map_x;
   int map_y;
   char * name;
   short life;
   short speed;
   short power;
   short armor;
   bag items;
public:
   character()
   character(const character& c);
   charact




































































































































