package com.game.worldlevel.message
{

    public class ResWorldLevelMessage extends WorldLevelMessage
    {
        public var worldLevel:int;

        public function ResWorldLevelMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600023;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.worldLevel = readInt();
            return true;
        }// end function

    }
}
