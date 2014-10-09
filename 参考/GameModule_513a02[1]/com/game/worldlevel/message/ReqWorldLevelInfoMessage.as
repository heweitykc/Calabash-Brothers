package com.game.worldlevel.message
{

    public class ReqWorldLevelInfoMessage extends WorldLevelMessage
    {

        public function ReqWorldLevelInfoMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600207;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
