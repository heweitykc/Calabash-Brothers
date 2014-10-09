package com.game.fight.model
{

    public class FightObj extends Object
    {
        private static var instance:FightObj;

        public function FightObj()
        {
            return;
        }// end function

        public static function getInstance() : FightObj
        {
            if (instance == null)
            {
                instance = new FightObj;
            }
            return instance;
        }// end function

    }
}
