package com.game.equip.message
{
    import com.game.equip.bean.*;
    import net.*;

    public class ResEquipChangeMessage extends Message
    {
        private var _item:EquipInfo;

        public function ResEquipChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._item);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._item = readBean(EquipInfo) as EquipInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 107006;
        }// end function

        public function get item() : EquipInfo
        {
            return this._item;
        }// end function

        public function set item(param1:EquipInfo) : void
        {
            this._item = param1;
            return;
        }// end function

    }
}
