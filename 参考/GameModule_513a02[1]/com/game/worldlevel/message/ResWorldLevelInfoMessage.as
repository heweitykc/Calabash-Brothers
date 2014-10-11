package com.game.worldlevel.message
{
    import __AS3__.vec.*;
    import com.game.worldlevel.bean.*;

    public class ResWorldLevelInfoMessage extends WorldLevelMessage
    {
        public var lastRefTime:int;
        public var arr:Vector.<WorldLevelRecord>;

        public function ResWorldLevelInfoMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600024;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.lastRefTime = readInt();
            this.arr = readBeans(new Vector.<WorldLevelRecord>, WorldLevelRecord);
            return true;
        }// end function

    }
}
