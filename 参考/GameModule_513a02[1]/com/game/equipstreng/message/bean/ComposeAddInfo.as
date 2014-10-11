package com.game.equipstreng.message.bean
{
    import com.game.utils.*;
    import net.*;

    public class ComposeAddInfo extends Bean
    {
        private var _equip_id:long;

        public function ComposeAddInfo()
        {
            return;
        }// end function

        public function set equip_id(param1:long) : void
        {
            this._equip_id = param1;
            return;
        }// end function

        public function get equip_id() : long
        {
            return this._equip_id;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._equip_id);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._equip_id = readLong();
            return true;
        }// end function

    }
}
