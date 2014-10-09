package com.game.equip.message
{
    import com.game.equip.bean.*;
    import net.*;

    public class WearEquipItemMessage extends Message
    {
        private var _equip:EquipInfo;
        private var _pos:int;

        public function WearEquipItemMessage()
        {
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._equip);
            writeInt(this._pos);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._equip = readBean(EquipInfo) as EquipInfo;
            this._pos = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 106101;
        }// end function

        public function get equip() : EquipInfo
        {
            return this._equip;
        }// end function

        public function set equip(param1:EquipInfo) : void
        {
            this._equip = param1;
            return;
        }// end function

    }
}
