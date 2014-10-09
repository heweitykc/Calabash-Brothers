package com.game.horse.message
{
    import net.*;

    public class ReshorseStageUpPanelMessage extends Message
    {
        private var _gold:int;
        private var _yuanbao:int;

        public function ReshorseStageUpPanelMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._gold);
            writeInt(this._yuanbao);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._gold = readInt();
            this._yuanbao = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 126104;
        }// end function

        public function get gold() : int
        {
            return this._gold;
        }// end function

        public function set gold(param1:int) : void
        {
            this._gold = param1;
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
