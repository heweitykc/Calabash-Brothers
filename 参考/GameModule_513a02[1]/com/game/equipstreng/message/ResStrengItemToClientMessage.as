package com.game.equipstreng.message
{
    import com.game.equip.bean.*;
    import net.*;

    public class ResStrengItemToClientMessage extends Message
    {
        private var _equipInfo:EquipInfo;
        private var _issuccess:int;
        private var _itemlevel:int;
        private var _addAttributLevel:int;

        public function ResStrengItemToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._equipInfo);
            writeByte(this._issuccess);
            writeByte(this._itemlevel);
            writeByte(this._addAttributLevel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._equipInfo = readBean(EquipInfo) as EquipInfo;
            this._issuccess = readByte();
            this._itemlevel = readByte();
            this._addAttributLevel = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 130101;
        }// end function

        public function get equipInfo() : EquipInfo
        {
            return this._equipInfo;
        }// end function

        public function set equipInfo(param1:EquipInfo) : void
        {
            this._equipInfo = param1;
            return;
        }// end function

        public function get issuccess() : int
        {
            return this._issuccess;
        }// end function

        public function set issuccess(param1:int) : void
        {
            this._issuccess = param1;
            return;
        }// end function

        public function get itemlevel() : int
        {
            return this._itemlevel;
        }// end function

        public function set itemlevel(param1:int) : void
        {
            this._itemlevel = param1;
            return;
        }// end function

        public function get addAttributLevel() : int
        {
            return this._addAttributLevel;
        }// end function

        public function set addAttributLevel(param1:int) : void
        {
            this._addAttributLevel = param1;
            return;
        }// end function

    }
}
