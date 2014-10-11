package com.game.equipstreng.message
{
    import com.game.equip.bean.*;
    import net.*;

    public class ResStageUpItemToClientMessage extends Message
    {
        private var _equipInfo:EquipInfo;
        private var _issuccess:int;

        public function ResStageUpItemToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._equipInfo);
            writeByte(this._issuccess);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._equipInfo = readBean(EquipInfo) as EquipInfo;
            this._issuccess = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 130102;
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

    }
}
