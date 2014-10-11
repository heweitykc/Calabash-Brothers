package com.game.horse.message
{
    import net.*;

    public class ResOpenSkillUpPanelMessage extends Message
    {
        private var _boxnum:int;
        private var _money:int;
        private var _yuanbao:int;

        public function ResOpenSkillUpPanelMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._boxnum);
            writeInt(this._money);
            writeInt(this._yuanbao);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._boxnum = readByte();
            this._money = readInt();
            this._yuanbao = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 126113;
        }// end function

        public function get boxnum() : int
        {
            return this._boxnum;
        }// end function

        public function set boxnum(param1:int) : void
        {
            this._boxnum = param1;
            return;
        }// end function

        public function get money() : int
        {
            return this._money;
        }// end function

        public function set money(param1:int) : void
        {
            this._money = param1;
            return;
        }// end function

        public function get yuanbao() : int
        {
            return this._yuanbao;
        }// end function

        public function set yuanbao(param1:int) : void
        {
            this._yuanbao = param1;
            return;
        }// end function

    }
}
