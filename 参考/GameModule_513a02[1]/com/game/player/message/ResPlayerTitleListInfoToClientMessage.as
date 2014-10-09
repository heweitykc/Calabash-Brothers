package com.game.player.message
{
    import net.*;

    public class ResPlayerTitleListInfoToClientMessage extends Message
    {
        public var ids:Array;
        public var tms:Array;

        public function ResPlayerTitleListInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            this.ids = [];
            this.tms = [];
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = readInt();
                _loc_4 = readInt();
                this.ids.push(_loc_3);
                this.tms.push(_loc_4);
                _loc_2++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 529108;
        }// end function

    }
}
