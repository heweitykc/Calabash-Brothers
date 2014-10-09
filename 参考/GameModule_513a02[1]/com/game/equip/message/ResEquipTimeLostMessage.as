package com.game.equip.message
{
    import com.game.utils.*;
    import net.*;

    public class ResEquipTimeLostMessage extends Message
    {
        private var _equipId:long;

        public function ResEquipTimeLostMessage()
        {
            return;
        }// end function

        public function set equipId(param1:long) : void
        {
            this._equipId = param1;
            return;
        }// end function

        public function get equipId() : long
        {
            return this._equipId;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._equipId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._equipId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 106203;
        }// end function

    }
}
